#!/usr/bin/env bash

if [ $( id -u ) == 0 ]; then

cat << EOF

                                  '' '/++++++.                                  
                         -o++:+++s+/+o-     'oo                                 
                     +o+/:  '/'               d++:'                             
                    /+                        .  :/+s.                          
                   /s-                              .h/'                        
                  y/                                  +o                        
                  h-                                  .d                        
                 +o'                                 .oo                        
                 /o                                 'ys+/-'                     
                 :s                            :o:-:s-  '-+o.                   
                  /s.                  .s++oo++o'.-+o      'y-                  
                   .os:           'o+++o'          -hoo+y'  .y                  
                     /o            h.              .d'  -y   d                  
                      +d.         /y               'd    m   y.                 
                      'Mo       -s:                 h    h.  o:                 
                      'dy-     'y.                  d'   y-  //                 
                      'd'oo:-:+s.                   h'   y-  :+                 
                      'd   .-.                      h.   y-  :o                 
                      'd                            s:  'd'  /o                 
                      'd                            o/./y-   y-                 
                      'd                            /s:.   'o/                  
                      'd                            :o  '-+o-                   
                      'd                            -h/+/-'                     
                      .m.                          -sd'                         
                      h:+++:'                 '-/+o/'-y                         
                     .h   '-/+++++++++++++++++/:'     d                         
                     .h                             '/o                         
                      :o+/-'                   './+o+.                          
                         '-/+++++++++++++++++++/:.        
EOF

else

cat << EOF
                                            ./                                                      
                                             -: '     :                                             
                                              o /     +                                             
                                             .+ o     o.                                            
                                            -s  s     +-                                            
                                           +o  /:     o.                                            
                                         :s-  +/      y                                             
                                       'o:  -o-      .s                                             
                                       s-  //'       y'                                             
                                       y.  d        o:                                              
                                '.-:///sdo+ds++++ooyhoo+++//:-.'                                    
                           '-/+o+/-..'''-s 's      o'  '''..-:/oo+/-                                
                         '+o:.'          +: +-     y            ''-+y/                              
                         +o        '..-.-y+-y/:----h--.'            .N:                             
                         yh:. .--::-..''':''.''''''s-'.-::::-..'  '-oNs+/://:                       
                         s+./os+:.'     '........' ..       .-:oyoo/-m/::--.:s'                     
                         +o   '.-:/+++///////////:::::://++o+/:-.'   N:.'''s +/                     
                         -h          '''...----------...'''         .d    'y'o:                     
                         'm                                         /h:::/:.:+                      
                          d-                                        y+:::-:+-                       
                      '.:/ho                                       'mmdy+:.                         
                    .+so:..d'                                      +o.-+ss/'                        
                   +d/'    :y'                                    :y'    .yd-                       
                  .Mo       :s.                                  /s'      'Mh                       
                  .mh'       .s:'                              .o/        +my                       
                   sys:'       /o:'                          .++.       .oyh.                       
         '::-'      +soo/.'      :+/.'                    ':+/.      '-osss.                        
  .-/++:'-s+o/+      .oo/+++:.''   ./++:.''          '.-/+/-    ''-/o++os:                          
 os+:-:o+'/::os        '/o/-://++/:.'''-///+++++++++++/:.''.-/+++//-:oo-                            
 .+o:+++s/ '.--:.  '''''' ./oo/-'.-:///////////////////////:-.''-+++:'                              
  +o+:///''.o:---//ooo+oo.    .:++++/:-.'''''''''''''''.-:/+++//-'                                  
.++++:-:/o+os/o/osyo///oo'          '.:://+++++/+++++///:-.                                         
s::.':h--.-://+/:-h:--.:h.                                                                          
 :////-'..'       ':-:/:'   
EOF

fi