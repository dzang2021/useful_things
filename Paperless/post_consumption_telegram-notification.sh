#!/bin/bash

##
# 1. Create a new bot in telegram.
# 2. Note the BOT-TOKEN and start the bot
# 3. Create an new group with the new bot and send a test message
# 4. Get the chat-id by open the url within the webbrowser https://api.telegram.org/bot<your_bot_id>/getUpdates
# 5. Adjust the below variables with your data
# 6. Save the script to your paperless instance and configure paperless to use it.
#    >> Docker-Compose
#    >>>> volumes:
#    >>>>  - /<your path>/paperless/Scripts:/home/scripts
#
#    >>>> environment:
#    >>>>  - PAPERLESS_POST_CONSUME_SCRIPT: "/home/scripts/post_consumption_telegram-notification.sh"
#
# Feel free to adjust the script with your needed content :)
# Enjoy!!!
##

TOKEN="<BOT-TOKEN>"
ID="<CHAT_ID>"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

MESSAGE=$(echo "

Neues Dokument erfolgreich hochgeladen.

Dokumenten ID: ${DOCUMENT_ID}
* Generated File Name: ${DOCUMENT_FILE_NAME}
* Archive Path: ${DOCUMENT_ARCHIVE_PATH}
* Source Path: ${DOCUMENT_SOURCE_PATH}
* Created: ${DOCUMENT_CREATED}
* Added: ${DOCUMENT_ADDED}
* Modified: ${DOCUMENT_MODIFIED}
* Thumbnail Path: ${DOCUMENT_THUMBNAIL_PATH}
* Download URL: ${DOCUMENT_DOWNLOAD_URL}
* Thumbnail URL: ${DOCUMENT_THUMBNAIL_URL}
* Correspondent: ${DOCUMENT_CORRESPONDENT}
* Tags: ${DOCUMENT_TAGS}

It was consumed with the passphrase ${PASSPHRASE}")

curl -s -X POST $URL -d chat_id=$ID -d text="$(echo -e "$MESSAGE")" > /dev/null 2>&1
