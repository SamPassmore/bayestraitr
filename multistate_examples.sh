#!/bin/bash


# MultiState & ML
BayesTraitsV3 ./bayestraits_output/Artiodactyl.trees ./bayestraits_output/Artiodactyl.txt << input
1; 
1; 
LogFile ./bayestraits_output/MS_ML
run;
input

# MultiState & MCMC
BayesTraitsV3 ./bayestraits_output/Artiodactyl.trees ./bayestraits_output/Artiodactyl.txt << input
1; 
2;
PriorAll exp 10; 
LogFile ./bayestraits_output/MS_MCMC
run;
input

# MultiState & MCMC w/ Stepping stones
BayesTraitsV3 ./bayestraits_output/Artiodactyl.trees ./bayestraits_output/Artiodactyl.txt << input
1; 
2;
PriorAll exp 10; 
Stones 100 1000;
LogFile ./bayestraits_output/MS_MCMC_wSS
run;
input

# MultiState & MCMC w/ Stepping stones & parameter restriction
BayesTraitsV3 ./bayestraits_output/Artiodactyl.trees ./bayestraits_output/Artiodactyl.txt << input
1; 
2;
PriorAll exp 10; 
Stones 100 1000;
Restrict qDG qGD; 
LogFile ./bayestraits_output/MS_MCMC_wSS_wPR
run;
input

# MultiState & ML w/ Stepping stones & parameter restriction
BayesTraitsV3 ./bayestraits_output/Artiodactyl.trees ./bayestraits_output/Artiodactyl.txt << input
1; 
1;
PriorAll exp 10; 
Restrict qDG qGD; 
LogFile ./bayestraits_output/MS_ML_wSS_wPR
run;
input

# MultiState & MCMC w/ Stepping stones & tags
BayesTraitsV3 ./bayestraits_output/Artiodactyl.trees ./bayestraits_output/Artiodactyl.txt << input
1; 
2;
AddTag TRecNode Porpoise Dolphin FKWhale Whale;
AddNode RecNode TRecNode;
LogFile ./bayestraits_output/MS_MCMC_wSS_wTag
run;
input

# MultiState & MCMC w/ MRCA
BayesTraitsV3 ./bayestraits_output/Artiodactyl.trees ./bayestraits_output/Artiodactyl.txt << input
1; 
2;
PriorAll exp 10;
Res qDG qGD;
AddTag TVarNode Sheep Goat Cow Buffalo Pronghorn;
AddNode VarNode TVarNode;
LogFile ./bayestraits_output/MS_MCMC_wSS_wMRCA
run;
input

# MultiState & MCMC w/ Fossilisation
BayesTraitsV3 ./bayestraits_output/Artiodactyl.trees ./bayestraits_output/Artiodactyl.txt << input
1; 
2;
AddTag FNode Sheep Goat Cow Buffalo Pronghorn;
Fossil Node01 FNode D
LogFile ./bayestraits_output/MS_MCMC_wF
run;
input

# MultiState w/ fossilisation for continuous variables  
BayesTraitsV3 ./bayestraits_output/Mammal.trees ./bayestraits_output/MammalModelB.txt << input
4;
2;
AddTag Tag-01 Dorcopsulus_macleayi Dorcopsulus_vanheurni;
Fossil Node01 Tag-01 90.95;
LogFile ./bayestraits_output/MS_MCMC_Cont
run;

