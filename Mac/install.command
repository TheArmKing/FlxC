#!/bin/bash
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cat <<EOF > /usr/local/bin/FlxC.sh
#!/bin/bash
if [ -f "/tmp/tweak.txt" ]; then rm /tmp/tweak.txt; fi
if [ ! -d "\$HOME/Documents/FlexC" ]; then mkdir "\$HOME/Documents/FlexC"; fi;
if [ ! -f "\$HOME/Documents/FlexC/patches.plist" ]; then echo -en "\x1B[1;49;91mCouldn't find patches.plist\x1B[0m file @\$HOME/Documents/FlexC\n" && exit; fi
if [ "\$*" == "" ]; then
  conm="\$(xmllint --xpath "count(/plist/dict/array/dict)" \$HOME/Documents/FlexC/patches.plist)"
  qko=()
  for (( b=1; b<=\$conm; b++ )); do
    jbk="\$(xmllint --xpath "/plist/dict/array/dict[\$b]/key[text()='name']/following-sibling::string[position()=1]/text()" \$HOME/Documents/FlexC/patches.plist)"
    qko+=( "\$jbk" )
  done
  PS3="Choose a Patch! : "
  select hu in "\${qko[@]}" "Help" "Quit"; do
    if [[ -n "\$hu" ]]; then
      if [ "\$hu" == "Help" ]; then
        echo -en "\x1B[5;40;97mFlxC -> Flex2Hook Converter\x1B[0m\n\n\x1B[1;49;96mUsage:\x1B[0m\n\x1B[1;49;39mFlxC\x1B[0m (Shows Menu to select Patch)\n\x1B[1;49;39mFlxC [ Patch Name ]\x1B[0m\n\n\x1B[1;49;39mIF\x1B[0m you find any \x1B[1;49;91mbugs\x1B[0m then contact @\x1B[1;49;32mTheArmKing\x1B[0m on \x1B[1;49;94mDiscord\x1B[0m: \x1B[1;49;39mTheArmKing#6647\x1B[0m\n"
      elif [ "\$hu" == "Quit" ]; then
        exit
      else
        pewt="\$hu"
        break
      fi
    else
      echo -en "\x1B[1;49;91mInvalid Choice!\x1B[0m\n"
    fi
  done
else
  pewt="\$*"
fi
co="\$(xmllint --xpath "count(/plist/dict/array/dict[.//string='\$pewt'])" \$HOME/Documents/FlexC/patches.plist)"
if [ "\$co" -lt "1" ]; then echo -en "\x1B[1;49;91mNo Patch Found!\x1B[0m\n" && exit;
elif [ "\$co" -gt "1" ]; then echo -en "\x1B[1;49;91mMultiple Patches\x1B[0m by the name of \$pewt were found! \x1B[1;49;91mRename\x1B[0m one of them\n" && exit; fi
ef1="\$(xmllint --xpath "count(/plist/dict/array/dict[.//string='\$pewt']/array/dict[//key='methodObjc'])" \$HOME/Documents/FlexC/patches.plist)"
if [ "\$ef1" -lt "1" ]; then echo -en "\x1B[1;49;91mNo Classes Found in Patch!\x1B[0m\n" && exit; fi
echo -en "// Generated using FlxC.sh! If you find any bugs then contact @TheArmKing on Discord: TheArmKing#6647\n\n#include <substrate.h>\n" >>/tmp/tweak.txt
cles=()
if [ "\$co" == "1" ]; then idy="\$(xmllint --xpath "/plist/dict/array/dict[.//string='\$pewt']/key[text()='appIdentifier']/following-sibling::string[position()=1]/text()" \$HOME/Documents/FlexC/patches.plist)" && echo -en "\x1B[1;49;92mPatch Found!\x1B \x1B[1;49;39m\bundleID=$idy\x1B[0m\n\n"; fi
totalj=0
for (( x=1; x<=\$ef1; x++ )); do
  je1="\$(xmllint --xpath "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/dict/key[text()='className']/following-sibling::string[position()=1]/text()" \$HOME/Documents/FlexC/patches.plist)"
  je2="\$(xmllint --xpath "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/dict/key[text()='displayName']/following-sibling::string[position()=1]/text()" \$HOME/Documents/FlexC/patches.plist)"
  je3="\$(xmllint --xpath "count(/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[.//key='argument'])" \$HOME/Documents/FlexC/patches.plist)"
  arc="\$(echo "\$je2" | tr " " "\n" | grep -c ":(")"
  (( totalj = totalj + \$je3 ))
  if [ "\$je3" -ge "1" ]; then
    IFS=')' read -r -a ARYW <<< "\$je2"
    jwry=""
    XFW=("\${ARYW[@]:1}")
    for item in "\${XFW[@]}"
    do
        jwry="\${jwry}\${item})"
    done
    jc=0
    fc=1
    IFS=')' read -r -a ARY <<< "\$jwry"
    for var in "\${ARY[@]}"; do
      if [[ "\$var" == *":("* ]]; then ARY[\$jc]="\${var})arg\${fc}" && (( fc = fc + 1 )); fi
      (( jc = jc + 1 ))
    done
    final="\${ARYW[0]})\${ARY[@]} {"
    if [[ ! "\${cles[*]}" =~ "\$je1" ]]; then
      cles+=( "\$je1" )
      echo -en "\n%hook \$je1\n\$final\n">>/tmp/tweak.txt
      place="/tmp/tweak.txt"
    else
      echo -en "\$final\n">>/tmp/tweake.txt
      place="/tmp/tweake.txt"
      fko="\$je1"
    fi
    argid=()
    argco=()
    for (( y=1; y<=\$je3; y++ )); do
      id="\$(xmllint --xpath "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[\${y}]/key[text()='argument']/following-sibling::integer[position()=1]/text()" \$HOME/Documents/FlexC/patches.plist)"
      arg="\$(xmllint --xpath "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[\${y}]/dict[.//key='value']" \$HOME/Documents/FlexC/patches.plist)"
      benk="\$(echo "\$arg" | awk 'c&&!--c;/<key>value<\/key>/{c=1}' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*\$//')"
      if [ "\$benk" == "<true/>" ]; then erg="TRUE";
      elif [ "\$benk" == "<false/>" ]; then erg="FALSE";
      elif [ "\$benk" == "<string>(FLNULL)</string>" ]; then erg="NULL";
      else erg="\$(echo "\$benk" | awk -F[\>\<\/] '{print \$3}')"; fi
      if [[ "\$benk" == *"<float>"* ]]; then
        if [ "\${erg//./}" == "\${erg}" ]; then erg="\${erg}.0f";
        else erg="\${erg}f"; fi
      fi
      ns1="\$(xmllint --xpath "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[\${y}]/dict[.//key='subtype']/key[text()='subtype']/following-sibling::integer[position()=1]/text()" \$HOME/Documents/FlexC/patches.plist)"
      ns2="\$(xmllint --xpath "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[\${y}]/dict[.//key='subtype']/key[text()='type']/following-sibling::integer[position()=1]/text()" \$HOME/Documents/FlexC/patches.plist)"
      ns3="\$(xmllint --xpath "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[\${y}]/dict[.//key='value']/key[text()='type']/following-sibling::integer[position()=1]/text()" \$HOME/Documents/FlexC/patches.plist)"
      if ( [ "\$ns1" -gt "0" ] && [ "\$ns1" -le "4" ] ) && [ "\$ns2" == "1" ] && [ "\$ns3" == "1" ] ; then
        ve="\$(xmllint --xpath "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[\${y}]/dict[.//key='value']/key[text()='value']/following-sibling::*[position()=1]/text()" \$HOME/Documents/FlexC/patches.plist)"
        if [ "\$ns1" == "2" ]; then
          if [ "\${ve//./}" == "\$ve" ]; then erg="[NSNumber numberWithInteger: \$ve]"; else erg="[NSNumber numberWithFloat: \$ve]"; fi
        elif [ "\$ns1" == "1" ]; then
          erg="@\"\$ve\""
        elif [ "\$ns1" == "3" ]; then
          IFS=':' read -r -a art <<< "\$ve"
          IFS=',' read -r -a ae <<<  "\${art[1]}"
          if [ "\${ae[0]}" == "255" ]; then re=1.0; elif [ "\${ae[0]}" == "0" ]; then re=0.0; else re="0\$(echo "scale=6; \${ae[0]}/255" | bc -l)"; fi
          if [ "\${ae[1]}" == "255" ]; then g=1.0; elif [ "\${ae[1]}" == "0" ]; then g=0.0; else g="0\$(echo "scale=6; \${ae[1]}/255" | bc -l)"; fi
          if [ "\${ae[2]}" == "255" ]; then be=1.0; elif [ "\${ae[2]}" == "0" ]; then be=0.0; else be="0\$(echo "scale=6; \${ae[2]}/255" | bc -l)"; fi
          if [ "\${ae[3]}" == "255" ]; then a=1.0; elif [ "\${ae[3]}" == "0" ]; then a=0.0; else a="0\$(echo "scale=6; \${ae[3]}/255" | bc -l)"; fi
          erg="[UIColor colorWithRed:\$re green:\$g blue:\$be alpha:\$a]"
        elif [ "\$ns1" == "4" ]; then
          if [ "\$fsd" != "1" ]; then
            fsd=1
            awk 'NR==3{print "#import <Foundation/Foundation.h>"}1' /tmp/tweak.txt >/tmp/ffs.txt && rm /tmp/tweak.txt && mv /tmp/ffs.txt /tmp/tweak.txt
            awk 'NR==6{print ""}1' /tmp/tweak.txt >/tmp/ffs.txt && rm /tmp/tweak.txt && mv /tmp/ffs.txt /tmp/tweak.txt
            echo -en "@interface NSDate (MBDateCat)\n+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;\n@end\n\n@implementation NSDate (MBDateCat)\n+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {\n    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];\n    NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];\n    [components setYear:year];\n    [components setMonth:month];\n    [components setDay:day];\n    [components setHour:hour];\n    [components setMinute:minute];\n    [components setSecond:second];\n    return [calendar dateFromComponents:components];\n}\n@end\n" >/tmp/date.txt
            tail -r /tmp/date.txt>>/tmp/det.txt
            rm /tmp/date.txt
            while IFS= read -r lin; do
              awk -v "n=6" -v "s=\${lin}" '(NR==n) { print s } 1' /tmp/tweak.txt >/tmp/fileqw.txt
              rm /tmp/tweak.txt
              mv /tmp/fileqw.txt /tmp/tweak.txt
            done < /tmp/det.txt
            rm /tmp/det.txt
          fi
          if [ "\$fsd" == "1" ]; then
            IFS='T' read -r -a aee <<< "\$ve"
            IFS=':' read -r -a aoo <<< "\${aee[0]}"
            IFS='+' read -r -a auu <<< "\${aee[1]}"
            IFS='-' read -r -a aww <<< "\${aoo[1]}"
            IFS=':' read -r -a aqq <<< "\${auu[0]}"
            fm=0
            for de in "\${aww[@]}"; do
              if [ "\${de::1}" == "0" ]; then
                fx="\$(echo "\${de:1:\${#de}-1}")"
                aww[\$fm]="\$fx"
              fi
              (( fm = fm + 1 ))
            done
            fc=0
            for ded in "\${aqq[@]}"; do
              if [ "\${ded::1}" == "0" ]; then
                fxd="\$(echo "\${ded:1:\${#ded}-1}")"
                aqq[\$fc]="\$fxd"
              fi
              (( fc = fc + 1 ))
            done
            erg="[NSDate dateWithYear:"\${aww[0]}" month:"\${aww[1]}" day:"\${aww[2]}" hour:"\${aqq[0]}" minute:"\${aqq[1]}" second:"\${aqq[2]}"]"
          fi
        fi
      fi
      argid+=( "\$id" )
      argco+=( "\$erg" )
    done
    if [[ "\${argid[*]}" =~ "0" ]] ; then echo -en "return \${argco[0]};\n">>"\$place"; fi
    if [ "\$arc" -gt "0" ] && [ "\${argid[*]}" != "0" ] ; then
      if [[ ! "\${argid[*]}" =~ "0" ]]; then tert="return %orig ("; else tert="%orig ("; fi
      for (( r=1; r<=\$arc; r++ )); do
        if [[ ! "\${argid[*]}" =~ "\$r" ]]; then
          if [ "\$r" == "\$arc" ]; then
            tert="\${tert}arg\${r}"
          else
            tert="\${tert}arg\${r}, "
          fi
        else
          for i in "\${!argid[@]}"; do
             if [[ "\${argid[\$i]}" = "\${r}" ]]; then
                 jpt="\${i}"
             fi
          done
          if [ "\$r" == "\$arc" ]; then
            tert="\${tert}\${argco[\$jpt]}"
          else
            tert="\${tert}\${argco[\$jpt]}, "
          fi
        fi
      done
      tert="\${tert});"
        echo -en "\${tert}\n">>"\$place"
    fi
        if [ "\$place" == "/tmp/tweak.txt" ]; then
          echo -en "}\n%end\n">>/tmp/tweak.txt
        elif [ "\$place" == "/tmp/tweake.txt" ]; then
          echo -en "}\n">>/tmp/tweake.txt
          tail -r /tmp/tweake.txt>>/tmp/twek.txt
          rm /tmp/tweake.txt
          lol="\$(grep -n -m1 "%hook \$fko" /tmp/tweak.txt | cut -f1 -d:)"
          fre="\$(tail -n +\${lol} /tmp/tweak.txt | grep -n -m1 "%end" | cut -f1 -d:)"
          (( jd = lol + fre - 1 ))
          while IFS= read -r line; do
            awk -v "n=\${jd}" -v "s=\${line}" '(NR==n) { print s } 1' /tmp/tweak.txt >/tmp/fileqw.txt
            rm /tmp/tweak.txt
            mv /tmp/fileqw.txt /tmp/tweak.txt
          done < /tmp/twek.txt
          rm /tmp/twek.txt
        fi
  fi
done
xss=0
while IFS= read -r linee; do
  echo "\$linee"
done < /tmp/tweak.txt
pbcopy < /tmp/tweak.txt
echo -en "\n\x1B[1;49;92mCopied to Clipboard!\x1B[0m\n\n"
while (( !xss )); do
  read -e -p "\$(echo -en "\x1B[1;49;39mSave Output to File?[y/n] \x1B[0m: \n" )" choi
  if [ "\$choi" == "y" ]; then
    fdg=0
    ew=1
    while (( !fdg )); do
      if [ -f "\$HOME/Documents/FlexC/\${idy}(\${ew}).xm" ]; then
        (( ew = ew + 1 ))
      else
        cp /tmp/tweak.txt "\$HOME/Documents/FlexC/\${idy}(\$ew).xm"
        fdg=1
      fi
    done
    echo -en "\x1B[1;49;92mSaved\x1B[0m as \$HOME/Documents/FlexC/\${idy}(\$ew).xm\n"
    xss=1
  elif [ "\$choi" == "n" ]; then
    xss=1
  else
    echo -en "\x1B[1;49;91mInvalid Choice!\x1B[0m\n"
  fi
done
rm /tmp/tweak.txt
if [ "\$totalj" == "0" ]; then
  echo -en "\x1B[1;49;91mNo Arguments Found!\x1B[0m\n"
fi
EOF
chmod +x /usr/local/bin/FlxC.sh
ln -s /usr/local/bin/FlxC.sh /usr/local/bin/FlxC
chmod +x /usr/local/bin/FlxC
if [ ! -d "$HOME/Documents/FlexC" ]; then mkdir "$HOME/Documents/FlexC"; fi;
echo -en "\x1B[1;49;92mDone!\x1B[0m\n"
sleep 0.5
rm "$SCRIPTPATH/install.command"
