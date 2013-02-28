#!/bin/bash
#
# Tetris Game Version 3.0 Beta1 
# Developed by YongYe <expertshell@gmail.com>
# 11/01/2011 BeiJing China [Updated 12/5/2011]

box0=(4 30)
box1=(4 30 5 30)
box2=(4 28 4 30 4 32)
box3=(4 28 4 30 5 30)
box4=(4 30 4 32 5 28 5 30)
box5=(4 30 5 28 5 30 5 32)
box6=(4 32 5 28 5 30 5 32)
box7=(4 30 5 30 6 30 7 30)
box8=(4 28 5 28 5 30 5 32)
box9=(4 28 4 30 5 30 5 32)
box10=(4 28 4 30 5 28 5 30)
box11=(4 28 4 32 5 26 5 30 5 34)
box12=(4 30 4 32 5 30 6 28 6 30)
box13=(4 30 5 28 5 30 5 32 6 30)
box14=(4 28 4 32 5 30 6 28 6 32)
box15=(4 28 4 30 5 30 6 30 6 32)
box16=(4 28 4 32 5 28 5 30 5 32)
box17=(4 28 5 28 6 28 6 30 6 32)
box18=(4 28 4 30 5 30 5 32 6 32)
box19=(4 26 4 34 5 28 5 30 5 32)
box20=(4 26 4 34 5 28 5 32 6 30)
box21=(4 26 5 28 6 30 7 32 8 34)
box22=(4 26 4 28 4 30 4 32 4 34)
box23=(4 28 4 34 5 30 5 32 6 30 6 32 7 28 7 34)
box24=(4 30 5 28 5 32 6 26 6 30 6 34 7 28 7 32 8 30)
box25=(4 30 5 28 5 30 5 32 6 26 6 28 6 30 6 32 6 34 7 28 7 30 7 32 8 30)
box26=(4 26 4 28 4 30 4 34 5 30 5 34 6 26 6 28 6 30 6 32 6 34 7 26 7 30 8 26 8 30 8 32 8 34)
box27=(4 26 4 30 4 32 4 34 5 26 5 30 6 26 6 28 6 30 6 32 6 34 7 30 7 34 8 26 8 28 8 30 8 34)

mrx=[]
modh=3
modw=5
score=0
level=0
width=25
height=30
sigExit=30
sigLeft=26
sigDown=28
sigRight=27
sigRotate=25
sigAllDown=29
((hh=2*width+modw+6))
coltab=(1\;{30..37}\;{40..47}m)

corev(){ echo $?; } 
srann(){ box=(${!1}); }
rotxy(){ kbox="${sup}"; }
srbox(){ vor=($(ordxy ${1})); }
rsmap(){ ((map[u/2-modh]=0)); }
radom(){ echo -n $((RANDOM/1171)); }
racol(){ echo -n ${coltab[RANDOM/512]}; }
hmowh(){ echo -ne "\e[${i};$((modw+1))H"; }
check(){ (( map[(i-modh-1)*width+j/2-modh] == 0 )) && break; }
hdbox(){ echo -e "$(sed 's/\[\]/ /g' <(echo ${oldbox}))\e[0m"; }

infra()
{ 
   stty ${STTY}
   echo -e "\e[?25h\e[36;4H" 
}

ptbox()
{ 
   oldbox="${cdn}"
   echo -e "\e[${colbox}${cdn}\e[0m" 
}

regxy()
{ 
   ptbox
   locus="${sup}" 
}

getxy()
{ 
   [[ ${cdx} ]] && ((y=cy+(ccy-cdy)${2}2))
   eval ${1}+=\"${x} ${y} \"
}

pause()
{
   if (( ${2} == 0 )); then
         kill -s STOP ${1} 
   else
         kill -s CONT ${1}
   fi
}

Quit()
{
   case $# in
        0) echo -e "\e[?25h\e[36;25HGame Over!\e[0m" ;;
        1) kill -${sigExit} ${pid}
           infra ;;
        2) infra ;;
   esac
           exit
}

rmaxy()
{ 
   awk '{
          for(m=2; m<=NF; m+=2) 
             a[m/2-1]=$m
        } 
   END {
          for(i=0; i<=NF/2-1; ++i)
          { for(j=i+1; j<=NF/2-1; ++j)
             { if(a[i] > a[j])
                { v=a[i]
                   a[i]=a[j]
                   a[j]=v
                }
             } 
          }
          {
             for(n in a)
                print a[n]
          }
        }' <(echo ${box[@]})
}

ordxy()
{
   awk '{
          for(m=2; m<=NF; m+=2) 
          { y[m/2-1]=$m
             x[m/2-1]=$(m-1)
          }
        } 
   END {
          for(i=0; i<=NF/2-1; ++i)
          { for(j=i+1; j<=NF/2-1; ++j)
             { if(x[i] > x[j])
                { v=x[i]
                   x[i]=x[j]
                   x[j]=v
                   k=y[i]
                   y[i]=y[j]
                   y[j]=k
                }
             } 
          }
          {
             for(n in x)
                print x[n], y[n]
          }
        }' <(echo ${!1})
}

rmaxx()
{ 
   awk -v k=${i} '{
          for(m=1; m<=NF; m+=2)
          { if($(m+1)==k) 
             { if(q<$m) 
                 q=$m
             } 
          }
        } 
   END {
             print q
        }' <(echo ${box[@]}) 
}

initl()
{ 
   local rsyx
   ((rsyx=(i-modh-1)*width+j/2-modh))
   ((map[rsyx]=0))
   ((pam[rsyx]=0))
}

rtmrx()
{ 
   local rsxy
   ((rsxy=(i-modh-1)*width+j/2-modh))
   if (( map[rsxy] == 0 )); then
         echo -ne " " 
   else
         echo -ne "\e[${pam[rsxy]}${mrx}\e[0m"
   fi
}

srmap()
{ 
   local srx sry
   ((srx=(j-modh)*width+u/2-modh))
   ((sry=(j-modh-1)*width+u/2-modh))
   ((map[srx]=map[sry]))
   eval pam[srx]=\"${pam[sry]}\"
}

LOOP()
{
   local i j
   for((i=modh+1; i<=height+modh; ++i))
   do
        ${1} 
        for((j=modw+1; j<=2*(width-1)+modw+1; j+=2))
        do
             ${2}
        done
        ${3} 
   done
}

Loop()
{
   local u 
   for((u=modw+1; u<=2*(width-1)+modw+1; u+=2))
   do
          ${1} 
   done
}

mapbox()
{
   (( j <= 2*(width-1)+modw+1 )) && continue
   ((++line))
   for((j=i-1; j>=modh+1; --j))
   do
         Loop srmap
   done
         Loop rsmap
}

rscbox()
{
   srbox ${1}
   for((i=0; i<${#vor[@]}; i+=2))
   do
       (( ${3} >= 0 )) && ((clo=vor[i+1]+hh-${3})) || ((clo=vor[i+1]+hh+12))
       smobox+="\e[$((vor[i]-1));${clo}H${mrx}"
   done
   echo -e "$(sed 's/\[\]/ /g' <(echo ${!2}))\e[${!4}${smobox}\e[0m"
}

mrbox()
{
   smobox=
   (( ${5} != 0 )) && {
   srann box$(radom)[@]
   eval ${1}="(${box[@]})"
   colbox="$(racol)"
   eval ${6}=\"${colbox}\"
   rscbox box[@] ${3} ${4} colbox
   } || {
   eval ${1}="(${!2})"
   eval ${6}=\"${!7}\"
   rscbox ${2} ${3} ${4} ${7}
   }
   eval ${3}=\"${smobox}\"
}

ranbox()
{
   local value smobox clo i j 
   colbox="${cnewbox}"
   cLorbox="${cTorbox}"
   olbox=(${newbox[@]})
   Lorbox=(${Torbox[@]})
   mrbox newbox Lorbox[@] srcbox 24 ${#} cnewbox cLorbox 
   mrbox Torbox rosbox[@] scrbox 12 ${#} cTorbox crosbox
   mrbox rosbox rcsbox[@] csrbox 0 ${#} crosbox crcsbox
   smobox=
   srann box$(radom)[@]
   rcsbox=(${box[@]})
   crcsbox="$(racol)"
   rscbox box[@] crsbox -12 crcsbox
   crsbox="${smobox}"
   box=(${olbox[@]})
}

danbox()
{
   (( $# == 1 )) && {
        srann box$(radom)[@] 
        colbox="$(racol)"
        concxy box[@] regxy 
   } || {
   colbox="${cnewbox}"
   concxy newbox[@] regxy 
   }
   oldbox="${cdn}"
   if ! movebox locus; then
      kill -${sigExit} ${PPID}
      Quit
   fi
}

hrabox()
{
   local j x y p q yox line sum mus calcu scn
   sbos="\040\040"
   sum=$(awk '{print NF}' <(echo ${locus}))
   calcu=(x y x y-2 x y-4 x y+2 x y+4 x+1 y x+1 y-2 x+1 y+2)
   srbox locus
   for((i=0; i<${#vor[@]}; i+=2))
   do
       ((x=vor[i])) 
       ((y=vor[i+1]))
       ((yox=(x-modh-1)*width+y/2-modh))
       if (( sum == 16 )); then
             scn=
             for((j=0; j<${#calcu[@]}; j+=2))
             do
                     ((p=calcu[j]))
                     ((q=calcu[j+1]))
                     ((mus=(p-modh-1)*width+q/2-modh))
                  if (( p > modh && p <= height+modh && q <= 2*width+modw && q > modw )); then
                     scn+="\e[${p};${q}H${sbos}"
                     ((map[mus]=0))
                     ((pam[mus]=0))
                  fi
             done
             sleep 0.03
             echo -e "${scn}"
       else 
             ((map[yox]=1))
             pam[yox]="${colbox}"
       fi
   done
   line=0
   LOOP "" check mapbox
   (( line == 0 )) && return
   echo -e "\e[1;34m\e[$((modh+6));${hh}H$((score+=line*200-100))"
   (( score%5000 < line*200-100 && level < 20 )) && echo -e "\e[1;34m\e[$((modh+8));${hh}H$((++level))"
   echo -e "\e[0m"
   LOOP hmowh rtmrx
} 

persig()
{
   local sigSwap 
   ranbox 0
   danbox 0 
   for i in sigRotate sigLeft sigRight sigDown sigAllDown
   do
        trap "sig=${!i}" ${!i}
   done
   trap "Quit" ${sigExit} 
   while :
   do
       for ((i=0; i<20-level; ++i))
       do
            sleep 0.02
            sigSwap=${sig}
            sig=0
            case ${sigSwap} in
            ${sigRotate} ) transform ;;
            ${sigLeft} ) transform 0 -2 ;;
            ${sigRight} ) transform 0 2 ;;
            ${sigDown} ) transform 1 0 ;;
            ${sigAllDown}) 
            transform $(corev $(dropa)) 0 ;;
            esac
       done
       transform 1 0
   done
}

getsig()
{
   local pid key arry pool STTY sig
   pid=${1}
   arry=(0 0 0)
   pool=$(echo -ne "\e")
   STTY=$(stty -g)
   trap "Quit 0" INT TERM
   trap "Quit 0 0" ${sigExit}
   echo -ne "\e[?25l"
   while :
   do
           read -s -n 1 key
           arry[0]=${arry[1]}
           arry[1]=${arry[2]}
           arry[2]=${key}
           sig=0
           if [[ ${key} == ${pool} && ${arry[1]} == ${pool} ]];then Quit 0
           elif [[ "[${key}]" == ${mrx} ]]; then sig=${sigAllDown} 
           elif [[ ${arry[0]} == ${pool} && ${arry[1]} == "[" ]]; then
                     case ${key} in
                     A) sig=${sigRotate} ;;
                     B) sig=${sigDown} ;;
                     D) sig=${sigLeft} ;;
                     C) sig=${sigRight} ;;
                     esac
           else
                    case ${key} in
                     W|w) sig=${sigRotate} ;;
                     S|s) sig=${sigDown} ;;
                     A|a) sig=${sigLeft} ;;
                     D|d) sig=${sigRight} ;; 
                     P|p) pause ${pid} 0 ;;
                     R|r) pause ${pid} 1 ;;
                     Q|q) Quit 0 ;;
                     esac
           fi
                     (( sig != 0 )) && kill -${sig} ${pid}
   done
}

dropa()
{ 
   local cmax cury i j k 
   cury=($(rmaxy))
   for i in ${cury[@]}
   do
        cmax+="$(rmaxx) "
   done 
   cmax=(${cmax})
   for((i=0; i<height; ++i))
   do
       for((j=0; j<${#cmax[@]}; ++j))
       do 
           (( map[(cmax[j]+i-modh)*width+cury[j]/2-modh] == 1 || cmax[j]+i == height+modh )) && return ${i}
       done 
   done
}

movebox()
{
   local x y i j xoy 
   srbox ${1}
   ((smu=${#vor[@]}))
   for((i=0; i<${#vor[@]}; i+=2))
   do 
        ((x=vor[i]+dx))
        ((y=vor[i+1]+dy))
        ((xoy=(x-modh-1)*width+y/2-modh))
        (( xoy < 0 )) && return 1
        (( x <= modh || x > height+modh || y > 2*width+modw || y <= modw )) && return 1
            if (( map[xoy] == 1 )); then
               if (( smu == 2 )); then
                  for((j=height+modh; j>x; --j))
                  do
                        (( map[(j-modh-1)*width+y/2-modh] == 0 )) && return 0
                  done
               fi
               return 1
            fi
   done 
   return 0 
}

across()
{
   local i j m one 
   one=(${locus})
   ((i=one[0]))
   ((j=one[1]))
   ((m=(i-modh-1)*width+j/2-modh))
   (( map[m] == 1 )) && echo -e "\e[${i};${j}H\e[${pam[m]}${mrx}\e[0m"
}

concxy()
{
   local i sup
   srbox ${1}
   for((i=0; i<${#vor[@]}; i+=2))
   do 
       cdn+="\e[${vor[i]};${vor[i+1]}H${mrx}"
       sup+="${vor[i]} ${vor[i+1]} "
   done
   ${2} 
}

move()
{
   if movebox locus; then
        hdbox
        (( smu == 2 )) && across
        drbox
   else
        (( dx == 1 )) && {
        hrabox 
        danbox 
        ranbox
        }
   fi
}

drbox()
{
   local v
   for((v=0; v<${#box[@]}; v+=2))
   do
      ((box[v]+=dx))
      ((box[v+1]+=dy))
   done
   nbox=(${box[@]})
   concxy box[@] regxy
   box=(${nbox[@]})
}

getmn()
{
   BOX=(${!1})
   if (( ${#BOX[@]}%4 == 0 )); then
        ((${2}=BOX[${#BOX[@]}/2]))
        ((${3}=BOX[${#BOX[@]}/2+1]))
   else
        ((${3}=BOX[${#BOX[@]}/2]))
        ((${2}=BOX[${#BOX[@]}/2-1]))
   fi
}

loop()
{
   local x y cy ccx ccy cdx cdy 
   srbox ${1}
   for((i=0; i<${#vor[@]}; i+=2))
   do
       ((x=vor[i])) 
       ((y=vor[i+1]))
       ((ccx=x))
       ((ccy=y))
       ${2} ${3} "${4}"
       ((cy=y))
       ((cdx=ccx))
       ((cdy=ccy)) 
   done 
}

algo()
{
   local row col 
   srbox ${1}
   for((i=0; i<${#vor[@]}; i+=2))
   do
       ((col=m-vor[i]+n)) 
       ((row=m+vor[i+1]-n))
       mbox+="${row} ${col} " 
   done
}

sortxy()
{
   srbox ${1}
   for((i=0; i<${#vor[@]}; i+=2))
   do
       pbox+="${vor[i]} ${vor[i+1]} "
   done 
}

plusxy()
{
   local i
   for((i=0; i<${#pbox[@]}; i+=2))
   do
       ((pbox[i]+=mp-p))
       ((pbox[i+1]+=nq-q))
   done
}

rotate()
{ 
   local m n p q mp nq tbox mbox vbox kbox pbox 
   getmn box[@] mp nq 
   loop box[@] getxy vbox "/"
   vbox=(${vbox})
   getmn vbox[@] m n 
   algo vbox[@]
   mbox=(${mbox})
   loop mbox[@] getxy tbox "*"
   tbox=(${tbox})
   sortxy tbox[@]
   pbox=(${pbox})
   getmn pbox[@] p q 
   plusxy
   concxy pbox[@] rotxy
   if movebox kbox; then
       hdbox
       locus="${kbox}"
       ptbox
       box=(${kbox})
   else
       echo -e "\e[${colbox}${oldbox}\e[0m"
   fi
}

transform()
{ 
   local dx dy cdn vor smu
   dx=${1}
   dy=${2}
   (( $# != 0 )) && move || rotate
}

matrix()
{
   one=" "
   sr="\e[0m"
   two="${one}${one}"
   tre="${one}${two}"
   cps="${two}${tre}"
   spc="${cps}${cps}" 
   colbon="\e[1;36;44m"
   mcol="\e[32;40;1m"
   trx="${mrx}${mrx}"
   fk0="${colbon}${mrx}${sr}"
   fk1="${colbon}${trx}${sr}"
   fk2="${colbon}${mrx}${trx}${sr}"
   fk3="${colbon}${trx}${trx}${sr}"
   fk4="${mcol}${mrx}${sr}"
   fk5="${spc}${spc}"
   fk6="${mcol}${mrx}${trx}${sr}"
   fk="${tre}${fk0}${two}${fk3}${two}${fk3}"
   fk7="${fk1}${one}${fk1}${fk}${fk4}${two}${two}"
   fk8="${fk0}${one}row${one}${fk0}${tre}${fk0}${two}${fk0}${one}(x-m)/zoomx${two}"
   fk9="${one}=${one}${fk0}${two}${fk0}${spc}${tre}${one}${fk0}${tre}*${two}"
   fk10="${spc}${cps}${two}${fk0}${two}${fk0}${one}+${one}${fk0}${cps}${fk0}"
   fk11="${tre}${one}${fk0}${two}cos(a)${one}sin(a)${two}${fk0}${two}${fk0}${tre}${fk0}${two}m${two}${fk0}"
   fk12="${one}col${one}${fk0}${tre}${fk0}${two}${fk0}${one}(y-n)/zoomy${two}${fk0}${cps}${one}"
   fk13="${one}-sin(a)${one}cos(a)${two}${fk0}${two}${fk0}${tre}${fk0}${two}n${two}${fk0}"
   fk14="${fk1}${one}${fk1}${fk}${cps}${one}"
   fk15="${fk1}${two}${fk0}${tre}${fk1}${one}${fk1}"
   echo -e "\e[$((modh+23));${hh}HAlgorithm:${two}${fk2}${one}${fk5}${fk5}${fk2}${fk4}"
   echo -e "\e[$((modh+30));${hh}H${spc}${two}${fk0}${two}${two}${cps}${fk5}${fk5}${fk0}"
   echo -e "\e[$((modh+25));${hh}H${fk7}${fk1}${spc}${tre}${fk1}${two}${fk0}${tre}${fk1}${one}${fk1}"
   echo -e "\e[$((modh+26));${hh}H${fk8}${fk0}${fk4}${fk11}\e[$((modh+28));${hh}H${fk0}${fk12}${fk0}${fk13}"
   echo -e "\e[$((modh+24));${hh}H${two}${spc}${fk0}${spc}${tre}${two}${tre}${fk6}${fk5}${cps}${fk0}${fk4}"
   echo -e "\e[$((modh+22));${hh}H${tre}${fk5}${fk5}${fk5}${fk6}\e[$((modh+29));${hh}H${fk14}${fk1}${spc}${tre}${fk15}"
   echo -e "\e[$((modh+27));${hh}H${fk0}${cps}${fk0}${fk9}${fk0}${fk10}\e[$((modh+31));${hh}H${spc}${two}${fk2}${fk5}${fk5} ${fk2}"
}

bondary()
{
   clear
   boncol="\e[1;30;1;44m\e[7m"
   for((i=modw+1; i<=2*width+modw; i+=2))
   do
        echo -e "${boncol}\e[${modh};${i}H==\e[$((height+modh+1));${i}H==\e[0m"
   done
   for((i=modh; i<=height+modh+1; ++i))
   do
        echo -e "${boncol}\e[${i};$((modw-1))H||\e[${i};$((2*width+modw+1))H||\e[0m"
   done
}

rinfo()
{
   echo -e "\e[1;31m\e[$((modh+5));${hh}HScore\e[1;31m\e[$((modh+7));${hh}HLevel\e[0m"
   echo -e "\e[1;34m\e[$((modh+6));${hh}H${score}\e[1;34m\e[$((modh+8));${hh}H${level}\e[0m"
   echo -e "\e[$((modh+10));${hh}HQ|q|ESC === exit"
   echo -e "\e[$((modh+11));${hh}HP|p === pause\e[$((modh+12));${hh}HR|r === resume"
   echo -e "\e[$((modh+13));${hh}HW|w|up === rotate\e[$((modh+14));${hh}HS|s|down === one step down"
   echo -e "\e[$((modh+15));${hh}HA|a|left === one step left\e[$((modh+16));${hh}HD|d|right === one step right"
   echo -e "\e[$((modh+17));${hh}HSpace|enter === drop all down\e[1;36m\e[$((modh+19));${hh}HTetris Game Version 3.0 Beta1"
   echo -e "\e[$((modh+20));${hh}HYongYe <expertshell@gmail.com>\e[$((modh+21));${hh}H11/01/2011 BeiJing China [Updated 12/5/2011]"
}

   [[ "[${1}]" != ${mrx} ]] && {
       LOOP "" initl ""
       bondary
       rinfo
       matrix
       persig 
   } || { 
       bash $0 0 &
       getsig $!
   }
