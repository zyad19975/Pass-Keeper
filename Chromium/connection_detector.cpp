//#ifdef __cplusplus
extern "C" {
//#endif


#include <windows.h>
#include <tchar.h>

#include <setupapi.h>
#include <initguid.h>

#include <stdio.h>
#pragma comment(lib,"setupapi.lib")
#pragma comment(lib,"hid.lib") 
	// IMPORTANT this is the identification string for the FPGA (it's the vid&pid of the device)
	//i used my storage device vid&pid for testing till i know the FPGA's
	auto VID_PID_string = _T("vid_aaaa&pid_8816");
	// This is the GUID for the USB device class
	DEFINE_GUID(GUID_DEVINTERFACE_USB_DEVICE,
		0xA5DCBF10L, 0x6530, 0x11D2, 0x90, 0x1F, 0x00, 0xC0, 0x4F, 0xB9, 0x51, 0xED);
	// (A5DCBF10-6530-11D2-901F-00C04FB951ED)
	HDEVINFO                         hDevInfo;
	SP_DEVICE_INTERFACE_DATA         DevIntfData;
	PSP_DEVICE_INTERFACE_DETAIL_DATA DevIntfDetailData;
	SP_DEVINFO_DATA                  DevData;

	DWORD dwSize, dwType, dwMemberIdx;
	HKEY hKey;
	BYTE lpData[1024];

	//listen for the device connection 
	//and take action (for now printing device connected)
	void detect_connection();

	//listen for the device disconnecton
	//and take action (for now printing device connected)
	void detect_disconnection();
	


	int main()
	{
		//listen forever for the connection and disconnection of our device
		while (1)
		{
			detect_connection();
			detect_disconnection();
		}
		return 0;
	}
}


void detect_connection()
{
	//loop until you detect connection
	while (1)
	{
		// We will try to get device information set for all USB devices that have a
	// device interface and are currently present on the system (plugged in).
		hDevInfo = SetupDiGetClassDevs(
			&GUID_DEVINTERFACE_USB_DEVICE, NULL, 0, DIGCF_DEVICEINTERFACE | DIGCF_PRESENT);

		if (hDevInfo != INVALID_HANDLE_VALUE)
		{
			// Prepare to enumerate all device interfaces for the device information
			// set that we retrieved with SetupDiGetClassDevs(..)
			DevIntfData.cbSize = sizeof(SP_DEVICE_INTERFACE_DATA);
			dwMemberIdx = 0;

			// Next, we will keep calling this SetupDiEnumDeviceInterfaces(..) until this
			// function causes GetLastError() to return  ERROR_NO_MORE_ITEMS. With each
			// call the dwMemberIdx value needs to be incremented to retrieve the next
			// device interface information.

			SetupDiEnumDeviceInterfaces(hDevInfo, NULL, &GUID_DEVINTERFACE_USB_DEVICE,
				dwMemberIdx, &DevIntfData);

			while (GetLastError() != ERROR_NO_MORE_ITEMS)
			{

				// As a last step we will need to get some more details for each
				// of device interface information we are able to retrieve. This
				// device interface detail gives us the information we need to identify
				// the device (VID/PID), and decide if it's useful to us. It will also
				// provide a DEVINFO_DATA structure which we can use to know the serial
				// port name for a virtual com port.

				DevData.cbSize = sizeof(DevData);

				// Get the required buffer size. Call SetupDiGetDeviceInterfaceDetail with
				// a NULL DevIntfDetailData pointer, a DevIntfDetailDataSize
				// of zero, and a valid RequiredSize variable. In response to such a call,
				// this function returns the required buffer size at dwSize.

				SetupDiGetDeviceInterfaceDetail(
					hDevInfo, &DevIntfData, NULL, 0, &dwSize, NULL);

				// Allocate memory for the DeviceInterfaceDetail struct. Don't forget to
				// deallocate it later!
				DevIntfDetailData = (PSP_DEVICE_INTERFACE_DETAIL_DATA)HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, dwSize);
				DevIntfDetailData->cbSize = sizeof(SP_DEVICE_INTERFACE_DETAIL_DATA);

				if (SetupDiGetDeviceInterfaceDetail(hDevInfo, &DevIntfData,
					DevIntfDetailData, dwSize, &dwSize, &DevData))
				{
					// Finally we can start checking if we've found a useable device,
					// by inspecting the DevIntfDetailData->DevicePath variable.
					// The DevicePath looks something like this:
					//
					// \\?\usb#vid_04d8&pid_0033#5&19f2438f&0&2#{a5dcbf10-6530-11d2-901f-00c04fb951ed}
					//
					// The VID for Velleman Projects is always 10cf. The PID is variable
					// for each device:
					//
					//    -------------------
					//    | Device   | PID  |
					//    -------------------
					//    | K8090    | 8090 |
					//    | VMB1USB  | 0b1b |
					//    -------------------
					//
					// As you can see it contains the VID/PID for the device, so we can check
					// for the right VID/PID with string handling routines.

					//here we detect the connection
					if (NULL != _tcsstr((TCHAR*)DevIntfDetailData->DevicePath, VID_PID_string))
					{
						printf("device connected\n");
						return;
					}
				}
				HeapFree(GetProcessHeap(), 0, DevIntfDetailData);
				// Continue looping
				SetupDiEnumDeviceInterfaces(
					hDevInfo, NULL, &GUID_DEVINTERFACE_USB_DEVICE, ++dwMemberIdx, &DevIntfData);
			}

			SetupDiDestroyDeviceInfoList(hDevInfo);
		}
	}
}


void detect_disconnection()
{
	//loop until you detect disconnection
	while (1)
	{
		hDevInfo = SetupDiGetClassDevs(
			&GUID_DEVINTERFACE_USB_DEVICE, NULL, 0, DIGCF_DEVICEINTERFACE | DIGCF_PRESENT);

		if (hDevInfo != INVALID_HANDLE_VALUE)
		{
			DevIntfData.cbSize = sizeof(SP_DEVICE_INTERFACE_DATA);
			dwMemberIdx = 0;
			SetupDiEnumDeviceInterfaces(hDevInfo, NULL, &GUID_DEVINTERFACE_USB_DEVICE,
				dwMemberIdx, &DevIntfData);
			
			//this variable is for identifing if the device is still in the device list
			bool device_exists = false;
			while (GetLastError() != ERROR_NO_MORE_ITEMS)
			{
				DevData.cbSize = sizeof(DevData);

				SetupDiGetDeviceInterfaceDetail(
					hDevInfo, &DevIntfData, NULL, 0, &dwSize, NULL);

				DevIntfDetailData = (PSP_DEVICE_INTERFACE_DETAIL_DATA)HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, dwSize);
				DevIntfDetailData->cbSize = sizeof(SP_DEVICE_INTERFACE_DETAIL_DATA);

				if (SetupDiGetDeviceInterfaceDetail(hDevInfo, &DevIntfData,
					DevIntfDetailData, dwSize, &dwSize, &DevData))
				{
					// check if the current device is our deivce:
					if (NULL != _tcsstr((TCHAR*)DevIntfDetailData->DevicePath, VID_PID_string))
					{
						device_exists = true;
					}
				}
				HeapFree(GetProcessHeap(), 0, DevIntfDetailData);

				SetupDiEnumDeviceInterfaces(
					hDevInfo, NULL, &GUID_DEVINTERFACE_USB_DEVICE, ++dwMemberIdx, &DevIntfData);
			}
			//here we detect disconnection 
			if (!device_exists)
			{
				printf("device disconnected\n");
				return;
			}
			SetupDiDestroyDeviceInfoList(hDevInfo);
		}
	}
}