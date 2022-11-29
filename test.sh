#!/usr/bin/bash


loop_apps(){
	for D in apps/*; do [ -d "${D}" ] && generate_json ${D}; done
}

generate_json(){
	app=$1
	find ./${app} -type f -not -name "*.json" -print0 | while read -d $'\0' file
	do
		file_name=`basename $file`
		echo "$file"
		echo "$file_name"
		json_string=$(<$app/index.json)
		json_string=${json_string:-'{}'} 
		echo $json_string
		while IFS="" read -r p || [ -n "$p" ]
		do
		   	# json_string=`jq --arg key  "$file_name" --arg value0 "$p" '. | .[$key] += [$value0]' <<< $json_string`
			json_string=`jq --arg key  "$file_name" --arg value0 "$p" '. | .[$key] = (.[$key]+[$value0]|unique)' <<< $json_string`
		done < $file	
		echo $json_string > $app/index.json
	done

}

loop_apps
