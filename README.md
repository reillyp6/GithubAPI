# GithubAPI
Interrogate github API to retrieve and display data.

This program will take an initial username, access all of their repositories, all the repositories of all their followers, and store in a dataframe object: the name of each repository, the programming language corresponding to each repository (if not = NULL), and size in KB of each repository.
  I then calculate the frequency of occurrence of each language and and create a new dataframe, in which is stored all languages that have a frequency over "n_freq"(a user selected level of significance), the total KB of all repositories in that language and the average size of a repository in that language. The program then calculates and plots the average size of a repository with respect to the programming languages used.
 
Visualisations can be accessed at https://plot.ly/~reillyp6.
