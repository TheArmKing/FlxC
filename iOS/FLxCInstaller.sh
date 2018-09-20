#!/bin/bash
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cat <<EOF > /usr/local/bin/FlxC.sh
#!/bin/bash
if [ -f "/var/mobile/Documents/Flex/tweak.txt" ]; then rm /var/mobile/Documents/Flex/tweak.txt; fi
if [ ! -d "/var/mobile/Documents/Flex" ]; then echo -en "\e[1;49;91mNo Flex Found\e[0m @/var/mobile/Documents/Flex\n" && exit; fi;
if [ ! -d "/var/mobile/Documents/Flex/Converted" ]; then mkdir "/var/mobile/Documents/Flex/Converted"; fi;
if [ ! -f "/var/mobile/Documents/Flex/patches.plist" ]; then echo -en "\e[1;49;91mNo Patch Plist Found\e[0m @/var/mobile/Documents/Flex/patches.plist\n" && exit; fi;

plist_path="\$(readlink /var/mobile/Documents/Flex/patches.plist)"
xmlp() {
  abc="\$(echo "cat \$1" | xmllint --shell "\$plist_path")"
  IFS=\$'\n' read -rd '' -a aro <<< "\$abc"
  xval="\${aro[1]}"
}
count() {
  ad="\$(xmllint --shell "\$plist_path" <<<"xpath "\$1"")"
  IFS=\$'\n' read -rd '' -a ar <<< "\$ad"
  str="\${ar[0]}"
  cont="\$(echo "\$str" | tr -dc '0-9')"
}
if [ "\$*" == "" ]; then
  count "count(/plist/dict/array/dict)"
  conm="\$cont"
  qko=()
  for (( b=1; b<=\$conm; b++ )); do
    xmlp "/plist/dict/array/dict[\$b]/key[text()='name']/following-sibling::string[position()=1]/text()"
    jbk="\$xval"
    qko+=( "\$jbk" )
  done
  PS3="Choose a Patch! : "
  select hu in "\${qko[@]}" "Help" "Quit"; do
    if [[ -n "\$hu" ]]; then
      if [ "\$hu" == "Help" ]; then
        echo -en "\e[5;40;97mFlxC -> Flex2Hook Converter\e[0m\n\n\e[1;49;96mUsage:\e[0m\n\e[1;49;39mFlxC\e[0m (Shows Menu to select Patch)\n\e[1;49;39mFlxC [ Patch Name ]\e[0m\n\n\e[1;49;39mIF\e[0m you find any \e[1;49;91mbugs\e[0m then contact @\e[1;49;32mTheArmKing\e[0m on \e[1;49;94mDiscord\e[0m: \e[1;49;39mTheArmKing#6647\e[0m\n"
      elif [ "\$hu" == "Quit" ]; then
        exit
      else
        pewt="\$hu"
        break
      fi
    else
      echo -en "\e[1;49;91mInvalid Choice!\e[0m\n"
    fi
  done
else
  pewt="\$*"
fi
count "count(/plist/dict/array/dict[.//string='\$pewt'])"
co="\$cont"
if [ "\$co" -lt "1" ]; then echo -en "\e[1;49;91mNo Patch Found!\e[0m\n" && exit;
elif [ "\$co" -gt "1" ]; then echo echo -en "\e[1;49;91mMultiple Patches\e[0m by the name of \$pewt were found! \e[1;49;91mRename\e[0m one of them\n" && exit; fi
count "count(/plist/dict/array/dict[.//string='\$pewt']/array/dict[//key='methodObjc'])"
ef1="\$cont"
if [ "\$ef1" -lt "1" ]; then echo -en "\e[1;49;91mNo Classes Found in Patch!\e[0m\n" && exit; fi
echo -en "// Generated using FlxC.sh! If you find any bugs then contact @TheArmKing on Discord: TheArmKing#6647\n\n#include <substrate.h>\n" >>/var/mobile/Documents/Flex/tweak.txt
cles=()
if [ "\$co" == "1" ]; then xmlp "/plist/dict/array/dict[.//string='\$pewt']/key[text()='appIdentifier']/following-sibling::string[position()=1]/text()" && idy="\$xval" &&  echo -en "\e[1;49;92mPatch Found!\e[0m \e[1;49;39mbundleID=\$idy\e[0m\n\n"; fi
totalj=0
deg="\$(grep -n "<dict/>" "\$plist_path" | cut -f1 -d:)"
if [ "\$deg" != "" ]; then
  IFS=\$'\n' read -rd '' -a ar <<< "\$deg"
  for dsc in "\${ar[@]}"; do
    sed -e "\${dsc}d" "\$plist_path" >/var/mobile/Documents/Flex/dkt.txt
    rm "\$plist_path"
    mv /var/mobile/Documents/Flex/dkt.txt "\$plist_path"
  done
fi
for (( x=1; x<=\$ef1; x++ )); do
  xmlp "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/dict/key[text()='className']/following-sibling::string[position()=1]/text()"
  je1="\$xval"
  xmlp "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/dict/key[text()='displayName']/following-sibling::string[position()=1]/text()"
  je2="\$xval"
  count "count(/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[.//key='argument'])"
  je3="\$cont"
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
      echo -en "\n%hook \$je1\n\$final\n">>/var/mobile/Documents/Flex/tweak.txt
      place="/var/mobile/Documents/Flex/tweak.txt"
    else
      echo -en "\$final\n">>/var/mobile/Documents/Flex/tweake.txt
      place="/var/mobile/Documents/Flex/tweake.txt"
      fko="\$je1"
    fi
    argid=()
    argco=()
    for (( y=1; y<=\$je3; y++ )); do
      xmlp "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[\${y}]/key[text()='argument']/following-sibling::integer[position()=1]/text()"
      id="\$xval"
      xmlp "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[\${y}]/dict[.//key='value']/key[text()='value']/following-sibling::*"
      benk="\$xval"
      if [ "\$benk" == "<true/>" ]; then erg="TRUE";
      elif [ "\$benk" == "<false/>" ]; then erg="FALSE";
      elif [ "\$benk" == "<string>(FLNULL)</string>" ]; then erg="NULL";
      else erg="\$(echo "\$benk" | awk -F[\>\<\/] '{print \$3}')"; fi
      if [[ "\$benk" == *"<float>"* ]]; then
        if [ "\${erg//./}" == "\${erg}" ]; then erg="\${erg}.0f";
        else erg="\${erg}f"; fi
      fi
      xmlp "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[\${y}]/dict[.//key='subtype']/key[text()='subtype']/following-sibling::integer[position()=1]/text()"
      ns1="\$xval"
      xmlp "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[\${y}]/dict[.//key='subtype']/key[text()='type']/following-sibling::integer[position()=1]/text()"
      ns2="\$xval"
      xmlp "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[\${y}]/dict[.//key='value']/key[text()='type']/following-sibling::integer[position()=1]/text()"
      ns3="\$xval"
      if [[ \$ns1 =~ ^-?[0-9]+\$ ]]; then
        if ( [ "\$ns1" -gt "0" ] && [ "\$ns1" -le "4" ] ) && [ "\$ns2" == "1" ] && [ "\$ns3" == "1" ] ; then
          xmlp "/plist/dict/array/dict[.//string='\$pewt']/array/dict[\${x}]/array/dict[\${y}]/dict[.//key='value']/key[text()='value']/following-sibling::*[position()=1]/text()"
          ve="\$xval"
          if [ "\$ns1" == "2" ]; then
            if [ "\${ve//./}" == "\$ve" ]; then erg="[NSNumber numberWithInteger: \$ve]"; else erg="[NSNumber numberWithFloat: \$ve]"; fi
          elif [ "\$ns1" == "1" ]; then
            erg="@\"\$ve\""
          elif [ "\$ns1" == "3" ]; then
            IFS=':' read -r -a art <<< "\$ve"
            IFS=',' read -r -a ae <<<  "\${art[1]}"
            if [ "\${ae[0]}" == "255" ]; then re=1.0; elif [ "\${ae[0]}" == "0" ]; then re=0.0; else re="\$(echo - | awk "{print \${ae[0]} / 255}")"; fi
            if [ "\${ae[1]}" == "255" ]; then g=1.0; elif [ "\${ae[1]}" == "0" ]; then g=0.0; else g="\$(echo - | awk "{print \${ae[1]} / 255}")"; fi
            if [ "\${ae[2]}" == "255" ]; then be=1.0; elif [ "\${ae[2]}" == "0" ]; then be=0.0; else be="\$(echo - | awk "{print \${ae[2]} / 255}")"; fi
            if [ "\${ae[3]}" == "255" ]; then a=1.0; elif [ "\${ae[3]}" == "0" ]; then a=0.0; else a="\$(echo - | awk "{print \${ae[3]} / 255}")"; fi
            erg="[UIColor colorWithRed:\$re green:\$g blue:\$be alpha:\$a]"
          elif [ "\$ns1" == "4" ]; then
            if [ "\$fsd" != "1" ]; then
              fsd=1
              awk 'NR==3{print "#import <Foundation/Foundation.h>"}1' /var/mobile/Documents/Flex/tweak.txt >/var/mobile/Documents/Flex/ffs.txt && rm /var/mobile/Documents/Flex/tweak.txt && mv /var/mobile/Documents/Flex/ffs.txt /var/mobile/Documents/Flex/tweak.txt
              awk 'NR==6{print ""}1' /var/mobile/Documents/Flex/tweak.txt >/var/mobile/Documents/Flex/ffs.txt && rm /var/mobile/Documents/Flex/tweak.txt && mv /var/mobile/Documents/Flex/ffs.txt /var/mobile/Documents/Flex/tweak.txt
              echo -en "@interface NSDate (MBDateCat)\n+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;\n@end\n\n@implementation NSDate (MBDateCat)\n+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {\n    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];\n    NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];\n    [components setYear:year];\n    [components setMonth:month];\n    [components setDay:day];\n    [components setHour:hour];\n    [components setMinute:minute];\n    [components setSecond:second];\n    return [calendar dateFromComponents:components];\n}\n@end\n" >/var/mobile/Documents/Flex/date.txt
              tac /var/mobile/Documents/Flex/date.txt>>/var/mobile/Documents/Flex/det.txt
              rm /var/mobile/Documents/Flex/date.txt
              while IFS= read -r lin; do
                awk -v "n=6" -v "s=\${lin}" '(NR==n) { print s } 1' /var/mobile/Documents/Flex/tweak.txt >/var/mobile/Documents/Flex/fileqw.txt
                rm /var/mobile/Documents/Flex/tweak.txt
                mv /var/mobile/Documents/Flex/fileqw.txt /var/mobile/Documents/Flex/tweak.txt
              done < /var/mobile/Documents/Flex/det.txt
              rm /var/mobile/Documents/Flex/det.txt
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
              for (( am=0; am<2; am++ )); do
                jfk="\${aww[0]}"
                if [ "\${jfk::1}" == "0" ]; then
                  fx="\$(echo "\${jfk:1:\${#jfk}-1}")"
                  aww[0]="\$fx"
                fi
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
        if [ "\$place" == "/var/mobile/Documents/Flex/tweak.txt" ]; then
          echo -en "}\n%end\n">>/var/mobile/Documents/Flex/tweak.txt
        elif [ "\$place" == "/var/mobile/Documents/Flex/tweake.txt" ]; then
          echo -en "}\n">>/var/mobile/Documents/Flex/tweake.txt
          tac /var/mobile/Documents/Flex/tweake.txt>>/var/mobile/Documents/Flex/twek.txt
          rm /var/mobile/Documents/Flex/tweake.txt
          lol="\$(grep -n -m1 "%hook \$fko" /var/mobile/Documents/Flex/tweak.txt | cut -f1 -d:)"
          fre="\$(tail -n +\${lol} /var/mobile/Documents/Flex/tweak.txt | grep -n -m1 "%end" | cut -f1 -d:)"
          (( jd = lol + fre - 1 ))
          while IFS= read -r line; do
            awk -v "n=\${jd}" -v "s=\${line}" '(NR==n) { print s } 1' /var/mobile/Documents/Flex/tweak.txt >/var/mobile/Documents/Flex/fileqw.txt
            rm /var/mobile/Documents/Flex/tweak.txt
            mv /var/mobile/Documents/Flex/fileqw.txt /var/mobile/Documents/Flex/tweak.txt
          done < /var/mobile/Documents/Flex/twek.txt
          rm /var/mobile/Documents/Flex/twek.txt
        fi
  fi
done
xss=0
while IFS= read -r linee; do
  echo "\$linee"
done < /var/mobile/Documents/Flex/tweak.txt
pbcopy < /var/mobile/Documents/Flex/tweak.txt
echo -en "\n\e[1;49;92mCopied to Clipboard!\e[0m\n\n"
while (( !xss )); do
  read -e -p "\$(echo -en "\e[1;49;39mSave Output to File?[y/n] \e[0m: \n" )" choi
  if [ "\$choi" == "y" ]; then
    fdg=0
    ew=1
    while (( !fdg )); do
      if [ -f "/var/mobile/Documents/Flex/Converted/\${idy}(\$ew).xm" ]; then
        (( ew = ew + 1 ))
      else
        cp /var/mobile/Documents/Flex/tweak.txt "/var/mobile/Documents/Flex/Converted/\${idy}(\$ew).xm"
        fdg=1
      fi
    done
    echo -en "\e[1;49;92mSaved\e[0m as /var/mobile/Documents/Flex/Converted/\${idy}(\$ew).xm\n"
    xss=1
  elif [ "\$choi" == "n" ]; then
    xss=1
  else
    echo -en "\e[1;49;91mInvalid Choice!\e[0m\n"
  fi
done
if [ -f "/var/mobile/Documents/Flex/tweak.txt" ]; then rm "/var/mobile/Documents/Flex/tweak.txt"; fi
if [ "\$totalj" == "0" ]; then
  echo -en "\e[1;49;91mNo Arguments Found!\e[0m\n"
fi
EOF
chmod +x /usr/local/bin/FlxC.sh
ln -s /usr/local/bin/FlxC.sh /usr/local/bin/FlxC
chmod +x /usr/local/bin/FlxC
if [ ! -d "/var/mobile/Documents/Flex/Converted" ]; then mkdir "/var/mobile/Documents/Flex/Converted"; fi;
chmod a+w "/var/mobile/Documents/Flex/Converted"
echo -en "\e[1;49;92mDone!\e[0m\n"
sleep 0.5
rm "$SCRIPTPATH/FLxCInstaller.sh"
