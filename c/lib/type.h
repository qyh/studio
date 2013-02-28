#ifndef _TYPE_H
#define _TYPE_H


#define MAX_LEN 80

#define PROPERTY_NUM 5

#define SERVER_HOST "server_host"
#define DATABASE	"database"
#define USERNAME	"username"
#define PASSAWORD	"password"
#define PORT		"port"

typedef struct _config{
	char server_host[MAX_LEN];
	char database[MAX_LEN];
	char username[MAX_LEN];
	char password[MAX_LEN];
	unsigned short int port;
}Config, *pConfig;

typedef struct _property{
	char key[MAX_LEN];
	char value[MAX_LEN];
}Property, *pProperty;

#define _DATA_TYPE

typedef Property Data;

typedef Property RecvData;

static char *DB_CFG_STR[MAX_LEN] = {SERVER_HOST, DATABASE, USERNAME, PASSAWORD, PORT};

#endif
