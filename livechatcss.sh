figlet re-add livechat styling...
sleep 3
SEARCH="<meta charset=\"utf-8\"><title>"
REPLACE="<meta charset=\"utf-8\"><link rel=\"stylesheet\" type=\"text/css\" href=\"livechat/livechatcss.css\"><title>"
sed -ie 's|'"$SEARCH"'|'"$REPLACE"'|' /opt/Rocket.Chat/programs/server/assets/app/livechat/index.html

sleep 2

echo adding css to program.json
#check if program.josn contains livechatcss.css entry
ISTHERE=`jq '.manifest | map(.path) | join(",") | contains("livechatcss.css")' /opt/Rocket.Chat/programs/web.browser/program.json`

if $ISTHERE
then
 	figlet css found.
else
	figlet adding css...
    sudo jq '.manifest += [{
      "path": "app/livechat/livechatcss.css", 
      "where": "client",
      "type": "asset",
      "cacheable": false,
      "url": "/livechat/livechatcss.css",
      "size": 50406,
      "hash": "d12453fedc655c7b4746791fweffweda524aaabce4ff793",
      "sri": null
	}]'  /opt/Rocket.Chat/programs/web.browser/program.json > /opt/Rocket.Chat/programs/web.browser/program2.json
	sleep 2
	sudo cp -v /opt/Rocket.Chat/programs/web.browser/program2.json /opt/Rocket.Chat/programs/web.browser/program.json
fi

#to copy css before update?
#sudo cp -v /root/livechatcss.css /opt/Rocket.Chat/programs/web.browser/app/livechat/livechatcss.css
curl https://raw.githubusercontent.com/Fabulor/deploy.connect.vocn.org/main/livehcat.css -o /opt/Rocket.Chat/programs/web.browser/app/livechat/livechatcss.css
#https://raw.githubusercontent.com/Fabulor/deploy.connect.vocn.org/main/livehcat.css
#service rocketchat restart
#figlet restarting RC...
