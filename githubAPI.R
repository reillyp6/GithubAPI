install.packages("gh")
access_token = .token = '?????????'
Sys.setenv(GITHUB_PAT = "?????????") #set access token as a system variable 

gh_whoami()



initial_user = "phadej" #select an initial user
all_repos = gh("https://api.github.com/users/:username/repos",
               username = initial_user,
               .token =access_token, .limit=1000) #get all repos of selected user
n = length(all_repos) 

name= c() #create vectors to store data
lang= c()
size= c()

for(i in 1:n) #run for loop to get name, language and size of all user repositories
{
  if(is.null(all_repos[[i]]$language))
  {
    
  }
  else
  {
    name[i]=all_repos[[i]]$name 
    lang[i]=all_repos[[i]]$language
    size[i]=all_repos[[i]]$size
  }
}


df_phadej = data.frame(name, lang, size) #save all data to a dataframe object


