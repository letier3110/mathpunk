# lakos can be in \<user>\AppData\Local\Pub\Cache\bin\

lakos -o classes.dot .
dot -Tsvg classes.dot -Nfillcolor=steelblue2:steelblue4 -Nfontcolor=white -Ngradientangle=270 -o classes.svg