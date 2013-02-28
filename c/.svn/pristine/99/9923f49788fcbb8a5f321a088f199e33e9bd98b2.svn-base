/*
 *
 * Professional Linux Progamming - Storing retrieved data
 *
 */
#include <stdio.h>
#include <curl/curl.h>

int main(int argc, char **argv)
{
   CURL *curl;
   CURLcode result;
   FILE *headerfile, *bodyfile;

   headerfile = fopen("header.txt", "w");
   bodyfile = fopen("body.txt", "w");
   curl = curl_easy_init();
   if (!curl)
   {
      perror("curl");
      return 1;
   }
   curl_easy_setopt(curl, CURLOPT_URL, argv[1]);
   curl_easy_setopt(curl, CURLOPT_WRITEHEADER, headerfile);
   curl_easy_setopt(curl, CURLOPT_WRITEDATA, bodyfile);

   curl_easy_setopt(curl, CURLOPT_VERBOSE, 1);

   result = curl_easy_perform(curl);
   curl_easy_cleanup(curl);

   fclose(headerfile);
   fclose(bodyfile);
   return 0;
}
