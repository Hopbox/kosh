# kosh

Kosh is a collection of widely used configuration information about various applications and catagories


To use the NSinkParser (Example:- https://gitlab.com/netify.ai/public/netify-agent/-/blob/master/deploy/netify-sink.conf)
```
./NSinkParser.sh netify-sink.conf
```
To use the BLPListParser (It is to parse this project https://github.com/blocklistproject/Lists )

1. Clone the repo
```
git clone https://github.com/blocklistproject/Lists.git
```
2. If you want to use it to parse `apps` then then remove any others files and run
```
 ./BLPListParser.sh -a
``` 
2. If you want to use it to parse `catagoties` then then remove any others files and Run
```
 ./BLPListParser.sh -c
```