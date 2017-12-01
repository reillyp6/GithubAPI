access_token = .token = '38534a3e930c2b90b944a91fa891366714ac7684'

gh("/users/reillyp6/repos")
gh("/users/:username/repos", username = "reillyp6", .token = token)

users <- gh("/users", .limit = 20) #get first 20 users (ie. User ID's 1-20)

users #print user information

get_repos <- gh("/users/:username/repos", username = "reillyp6") #store all repos of selected user

?vapply

vapply(get_repos,"[[", "","name") #print name of all of selected users repos

get_repos #print all info re selected user's repos

