install.packages("gh")
access_token = .token = 'c59197c234b80be3f67996d2af2a0d9411df5373'
Sys.setenv(GITHUB_PAT = "c59197c234b80be3f67996d2af2a0d9411df5373") #set access token as a system variable 

gh_whoami()

#this program will take an initial username, access all of their repositories,
#all the repositories of all their followers, and store in a dataframe:
#the name of each repository, the language corresponding to each repository
#(if not = NULL), and size in KB of each repository. It then calculates
#the frequency of occurrence of each language and and creates a new dataframe,
#in which is stored all languages that have a frequency over "n_freq",
#a user selected level of significance, and also the total KB of all repositories
#in that language. The program then calculates and plots the average size of a repository
#per language.

#large dataset, initial user= "phadej", suggested n_freq=400
#stores ~13,000 repos, runtime~ 6m 30s

#Medium dataset, initial user= "vanpelt", suggested n_freq=100
#stores ~ 3,400 repos, runtime~ 1m 45s

#Small dataset, initial user= "Quackmatic", suggested n_freq=40
#stores ~ 500 repos, runtime~ 0m 15s


initial_user = "vanpelt" #select an initial user
n_freq = 100 #select level of significant frequency for programming language





all_repos = gh("https://api.github.com/users/:username/repos",
               username = initial_user,
               .token =access_token, .limit=1000) #get all repos of selected user
n = length(all_repos) 

df_size = 1

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
    name[df_size]=all_repos[[i]]$name 
    lang[df_size]=all_repos[[i]]$language
    size[df_size]=all_repos[[i]]$size
    
    df_size = df_size+1
  }
}

#save all data to a dataframe object

followers = gh("https://api.github.com/users/:username/followers",
               username = initial_user,
               .token =access_token, .limit=1000) #store all followers of initial user

inc = length(followers)

for(i in 1:inc)
{
  if(is.null(followers[[i]]$login)) #if there is no specified language for the repo
  {
    
  }
  else
  {
    user = followers[[i]]$login  #select the next follower
    print(user)
    all_repos = gh("https://api.github.com/users/:username/repos",
                   username = user,
                   .token =access_token, .limit=1000) #get all repos of selected follower
    n2 = length(all_repos)
    
    if(all_repos == "") #if user has no public repositories
    {
      
    }
    else
    {
      for(i in 1:n2) #run for loop to get name, language and size of all user repositories
      {
        if(is.null(all_repos[[i]]$language)) #if there is no specified language for the repo
        {
          
        }
        else
        {
          name[df_size]=all_repos[[i]]$name   #store all data in the vectors name, lang and size
          lang[df_size]=all_repos[[i]]$language
          size[df_size]=all_repos[[i]]$size
          
          df_size = df_size+1
        }
      }
    }
  }
}


#save all data to a dataframe object

df = data.frame(name, lang, size)

y = count(df, 'lang') #y is a new dataframe with the frequencies of each language

y = y[y$freq > n_freq,] #only work with languages with freq. over the significance level

total_kb = c(rep(0, length(y$lang))) #new vector to store total KB of each language 

for(m in 1:length(y$lang))
{
  for(i in 1:length(df[,1]))
  {
    if(y[m,1]==df$lang[i])
    {
        total_kb[m]= total_kb[m]+df$size[i]
    }
  }
}

y = cbind(y, total_kb) #join y and total_kb vector 

average_size = c() #calculate average size of repository in each language

for(i in 1:length(y$lang))
{
  average_size[i]= y$total_kb[i]/y$freq[i]
}

if(length(average_size)!=length(y$lang))
{
  print("None of the languages found meet the level of significance.
         Please choose a smaller value for n_freq and try again.")
}

if(length(average_size)==length(y$lang))
{
  y=cbind(y, average_size)
}


small_y = y
medium_y = y
large_y = y

write.csv(small_y, file = "small_y")
write.csv(medium_y, file = "medium_y")
write.csv(large_y, file = "large_y")


