
#include <initguid.h>
#include <windows.h>
#include <Setupapi.h>
#include <tchar.h>

#pragma comment(lib,"setupapi.lib")
#pragma comment(lib,"hid.lib") 
//Buffer length
#define BUFF_LEN 20

// get the com port id of the device with the specified vid and pid 
void GetComPort(TCHAR* pszComePort, const wchar_t* vid, const wchar_t* pid)
{
    HDEVINFO DeviceInfoSet;
    DWORD DeviceIndex = 0;
    SP_DEVINFO_DATA DeviceInfoData;
    PCWSTR DevEnum = L"FTDIBUS";
    TCHAR ExpectedDeviceId[80] = { 0 }; //Store hardware id
    BYTE szBuffer[1024] = { 0 };
    DEVPROPTYPE ulPropertyType;
    DWORD dwSize = 0;
    DWORD Error = 0;
    //create device hardware id
    wcscpy_s(ExpectedDeviceId, L"vid_");
    wcscat_s(ExpectedDeviceId, vid);
    wcscat_s(ExpectedDeviceId, L"&pid_");
    wcscat_s(ExpectedDeviceId, pid);
    //SetupDiGetClassDevs returns a handle to a device information set
    DeviceInfoSet = SetupDiGetClassDevs(
        NULL,
        DevEnum,
        NULL,
        DIGCF_ALLCLASSES | DIGCF_PRESENT);
    if (DeviceInfoSet == INVALID_HANDLE_VALUE)
        return;
    //Fills a block of memory with zeros
    ZeroMemory(&DeviceInfoData, sizeof(SP_DEVINFO_DATA));
    DeviceInfoData.cbSize = sizeof(SP_DEVINFO_DATA);
    //Receive information about an enumerated device
    while (SetupDiEnumDeviceInfo(
        DeviceInfoSet,
        DeviceIndex,
        &DeviceInfoData))
    {
        DeviceIndex++;
        //Retrieves a specified Plug and Play device property
        if (SetupDiGetDeviceRegistryProperty(DeviceInfoSet, &DeviceInfoData, SPDRP_HARDWAREID,
            &ulPropertyType, (BYTE*)szBuffer,
            sizeof(szBuffer),   // The size, in bytes
            &dwSize))
        {
            HKEY hDeviceRegistryKey;
            //Get the key
            hDeviceRegistryKey = SetupDiOpenDevRegKey(DeviceInfoSet, &DeviceInfoData, DICS_FLAG_GLOBAL, 0, DIREG_DEV, KEY_READ);
            if (hDeviceRegistryKey == INVALID_HANDLE_VALUE)
            {
                Error = GetLastError();
                break; //Not able to open registry
            }
            else
            {
                // Read in the name of the port
                wchar_t pszPortName[BUFF_LEN];
                DWORD dwSize = sizeof(pszPortName);
                DWORD dwType = 0;
                if ((RegQueryValueEx(hDeviceRegistryKey, L"PortName", NULL, &dwType, (LPBYTE)pszPortName, &dwSize) == ERROR_SUCCESS) && (dwType == REG_SZ))
                {
                    // Check if it really is a com port
                    if (_tcsnicmp(pszPortName, _T("COM"), 3) == 0)
                    {
                        int nPortNr = _ttoi(pszPortName + 3);
                        if (nPortNr != 0)
                        {
                            _tcscpy_s(pszComePort, BUFF_LEN, pszPortName);
                        }
                    }
                }
                // Close the key now that we are finished with it
                RegCloseKey(hDeviceRegistryKey);
            }
        }
    }
    if (DeviceInfoSet)
    {
        SetupDiDestroyDeviceInfoList(DeviceInfoSet);
    }
}
int _tmain(int argc, _TCHAR* argv[])
{
    //Store com port information
    TCHAR pszPortName[BUFF_LEN] = { 0 };
    //function to get com id
    GetComPort(pszPortName, L"aaaa", L"8816");
    //Print available com port
    wprintf(L"\n\n COM Port ID = %s\n", pszPortName);
    return 0;
}