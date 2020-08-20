#include<io.h>
#include<stdio.h>
#include<winsock2.h>
#include <string>
#include <vector>
using namespace std;

#pragma comment(lib,"ws2_32.lib") //Winsock Library


int main(int argc, char* argv[])
{
	WSADATA wsa;
	SOCKET s, new_socket;
	struct sockaddr_in server, client;
	int c;
	

	printf("\nInitialising Winsock...");
	if (WSAStartup(MAKEWORD(2, 2), &wsa) != 0)
	{
		printf("Failed. Error Code : %d", WSAGetLastError());
		return 1;
	}

	printf("Initialised.\n");

	//Create a socket
	if ((s = socket(AF_INET, SOCK_STREAM, 0)) == INVALID_SOCKET)
	{
		printf("Could not create socket : %d", WSAGetLastError());
	}

	printf("Socket created.\n");

	//Prepare the sockaddr_in structure
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = INADDR_ANY;
	server.sin_port = htons(7775);

	//Bind
	if (bind(s, (struct sockaddr*) & server, sizeof(server)) == SOCKET_ERROR)
	{
		printf("Bind failed with error code : %d", WSAGetLastError());
	}

	puts("Bind done");

	//Listen to incoming connections
	listen(s, 3);

	

	
	while (1)
	{
		//Accept and incoming connection
		puts("\n----\nWaiting for incoming connections...");
		c = sizeof(struct sockaddr_in);
		new_socket = accept(s, (struct sockaddr*) & client, &c);
		if (new_socket == INVALID_SOCKET)
		{
			printf("accept failed with error code : %d", WSAGetLastError());
		}

		puts("Connection accepted");

		if (new_socket != INVALID_SOCKET)
		{
			int n;
			do 
			{
				char buffer[256];
				n = recv(new_socket, buffer, 255, 0);
				//printf("number of bytes: %i\n", n);
				if (n < 0)
					printf("read failed with error code : %d", WSAGetLastError());
				vector <char> vec;
				for (int i = 0; i < n-1; i++)
					vec.push_back(buffer[i]);
				vec.push_back(NULL);
				char* command = &vec[0];
		

				printf("\n<--command received: %s\n", command);

				//connected for input commands
				//quit command
				if (strcmp(command, "quit") == 0)
				{
					printf("-->connection closed\n");
					char msg[] = "Goodbye :D\n";
					send(new_socket, msg, strlen(msg), 0);
					closesocket(new_socket);
					n = -1;
				}
				//list accounts from FPGA
				else if (strcmp(command, "list") == 0)
				{
					printf("-->list sent\n");
					char msg[] = "here is your list :D\n";
					send(new_socket, msg, strlen(msg), 0);
				}
				//empty string means lose connection 
				else if (strcmp(command, "") == 0)
				{
					printf("-->connection lost\n");
				}
				else
				{
					printf("-->command not supported\n");
					char msg[] = "command not supported :(\n";
					send(new_socket, msg, strlen(msg), 0);
				}
			} while (n > 0);
		}
	}
	return 0;
}