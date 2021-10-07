#!/bin/bash

# CREDIT: https://github.com/yurividal/dummyepgxml

## VARIABLES
### Your channels go here. add more channels as you want
numberofchannels=2
declare -a a0=("tvg-id-ABCnews" "ABC NEWS" "ABC News Live" "ABC News Live is a news channel for breaking news, live events, newscasts, and longer-form reports and documentaries operated by ABC News since 2018.")
declare -a a1=("tvg-id-CBSN" "CBSN" "CBS News Live" "Watch CBS News and get the latest, breaking news headlines of the day for national news and world news today.")
declare -a a2=("tvg-id-Food52" "Food52" "Food52 Live and Delicious" "Food52 is a gathering place for everyone who believes the kitchen is at the heart of the home, and food is the center of a life well-lived.")
declare -a a3=("tvg-id-Saveur" "Saveur" "Saveur: Authentic Recipes, Food, Drinks, Travel, How to Cook" "Saveur is an on-line gourmet, food, wine, and travel magazine that specializes in essays about various world cuisines.")
declare -a a4=("tvg-id-BonAppetit" "Bon Appetit" "Bon Appétit: Recipes, Cooking, Entertaining" "Bon Appétit is a monthly American food and entertaining magazine, that typically contains recipes, entertaining ideas, restaurant recommendations, and wine reviews.")
declare -a a5=("tvg-id-gags" "Gags" "Just for Laughs: Gags" "There's no sound, but there sure are plenty of laughs. This crazy Quebec-based troupe uses the city as its stage, and its inhabitants, or victims, as characters! People are caught in a twisted yet funny web of comedic deception.")
declare -a a6=("tvg-id-feud" "Family Feud" "Family Feud" "Family Feud is an American television game show created by Mark Goodson in which two families compete to name the most popular answers to survey questions.")
declare -a a7=("tvg-id-haunt" "Haunt TV" "Spooky and Scary: Haunt TV" "Love jump scares and ghosts that go bump in the night?! Good! You’re gonna love this channel. Start accessing hundreds of hours of ghostly series, on demand. Now the real question is: while you’re watching us, who is watching you?")
declare -a a8=("tvg-id-honor" "Honor TV" "Ring of Honor" "Ring of Honor is an American professional wrestling promotion based in Baltimore, Maryland. Ring of Honor was originally founded by Rob Feinstein on February 23, 2002, but would be under the ownership of Cary Silkin from 2004 until 2011, when the promotion was sold to Sinclair.")
declare -a a9=("tvg-id-ccuk" "Comedy Central UK" "Comedy Central Programming" "Comedy Central is a British pay television channel that carries comedy programming, both original and syndicated. This channel is specific to audiences within the United Kingdom and Ireland.")

starttimes=("000000" "060000" "120000" "180000")
endtimes=("060000" "120000" "180000" "235900")
BASEPATH="/Storage/Configs/iptv/xmltv"
DUMMYFILENAME=dummy.xml

		today=$(date +%Y%m%d)
		tomorrow=$(date --date="+1 day" +%Y%m%d)
		# tomorrow=$(date -v+1d +%Y%m%d)  ## if running on MAC or BSD
		echo '<?xml version="1.0" encoding="UTF-8"?>' > $BASEPATH/$DUMMYFILENAME
		echo '<tv generator-info-name="mydummy" generator-info-url="https://null.null/">' >> $BASEPATH/$DUMMYFILENAME
        numberofiterations=$(($numberofchannels - 1))
        echo "Creating Dummy Epg ..."


		for i in $(seq 0 $numberofiterations); do # Number of Dummys -1 
			tvgid=a$i[0]
			name=a$i[1]
			echo '    <channel id="'${!tvgid}'">' >> $BASEPATH/$DUMMYFILENAME
			echo '        <display-name lang="pt">'${!name}'</display-name>' >> $BASEPATH/$DUMMYFILENAME
			echo '    </channel>' >> $BASEPATH/$DUMMYFILENAME
		done

		for i in $(seq 0 $numberofiterations) ;do
			tvgid=a$i[0]
			title=a$i[2]
			desc=a$i[3]
			for j in {0..3}; do
					echo '    <programme start="'$today${starttimes[$j]}' +0000" stop="'$today${endtimes[$j]}' +0000" channel="'${!tvgid}'">' >> $BASEPATH/$DUMMYFILENAME
					echo '        <title lang="pt">'${!title}'</title>' >> $BASEPATH/$DUMMYFILENAME
					echo '        <desc lang="pt">'${!desc}'</desc>' >> $BASEPATH/$DUMMYFILENAME
					echo '    </programme>' >> $BASEPATH/$DUMMYFILENAME
			done
			for j in {0..3}; do
					echo '    <programme start="'$tomorrow${starttimes[$j]}' +0000" stop="'$tomorrow${endtimes[$j]}' +0000" channel="'${!tvgid}'">' >> $BASEPATH/$DUMMYFILENAME
					echo '        <title lang="pt">'${!title}'</title>' >> $BASEPATH/$DUMMYFILENAME
					echo '        <desc lang="pt">'${!desc}'</desc>' >> $BASEPATH/$DUMMYFILENAME
					echo '    </programme>' >> $BASEPATH/$DUMMYFILENAME
			done
		done

		echo '</tv>' >> $BASEPATH/$DUMMYFILENAME

echo "Done!"
sleep 2
