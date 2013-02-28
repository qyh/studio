#ifndef _CONFIG_H_
#define _CONFIG_H_

#include <stdio.h>
#include <stdlib.h>

#define MAX_LEN 80

#define SERVER_HOST 	"server_host"
#define DATABASE		"database"
#define USERNAME		"username"
#define PASSWORD		"password"
#define PORT			"port"

typedef struct _property{
	char key[MAX_LEN];
	char value[MAX_LEN];
}Property, *pProperty;

typedef Property SetData;
typedef pProperty pSetData;

typedef struct _set{
	SetData *pdata;
	size_t size;
	size_t capacity;
}Set, *pSet;

typedef struct _config{
	char server_host[MAX_LEN];
	char database[MAX_LEN];
	char username[MAX_LEN];
	char password[MAX_LEN];
	unsigned int port;
}Config, *pConfig;

int set_init(pSet* set_ptr);

int set_add(pSet* set_ptr, SetData data);

int set_delete(pSet set_ptr);



char *DB_CONFIG[MAX_LEN] = {SERVER_HOST, DATABASE, USERNAME, PASSWORD, PORT};


#endif

