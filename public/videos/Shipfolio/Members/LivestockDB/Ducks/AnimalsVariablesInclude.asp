<% 
SCRIPT_NAME = request.servervariables("SCRIPT_NAME")
ReturnPath = SCRIPT_NAME 
Directoryname = left(SCRIPT_NAME, len(SCRIPT_NAME) - 4)
PageName = left(SCRIPT_NAME, len(SCRIPT_NAME) - 4)
PageName = right(PageName, len(PageName) -1)
slashnum = instr(PageName, "/") - 1
PageName = left(PageName, slashnum)
Returnpathname = Directoryname
str1 = PageName
str2 = " "
If InStr(str1,str2) > 0 Then
PageName= Replace(str1,  str2, " ")
End If  

'response.write("PageName = " & PageName )

if lcase(PageName)="alpacas" then
PageName="Alpacas" 
signularanimal = "Alpaca"
SpeciesNamePlural ="Alpacas"
SpeciesID = 2
BreedIcon = "/icons/Alpacaiconwhite.png"
currentbreed="Alpacas"
currentbreed2 = "Alpacas"
end if 
if  lcase(PageName)="dogs" then
PageName="Dogs"
signularanimal = "Dog"
SpeciesNamePlural ="Dogs"
SpeciesID = 3
BreedIcon = "/icons/DogsIconwhite.png"
currentbreed="Dogs"
currentbreed2 = "Dogs"
end if 
if  lcase(PageName)="llamas" then
PageName="Llamas"
signularanimal = "Llama"
SpeciesNamePlural ="Llamas"
SpeciesID = 4
BreedIcon = "/icons/LlamaIconwhite.png"
currentbreed="Camelids"
currentbreed2 = "Llamas"
end if 
if  lcase(PageName)="horses" then
PageName="Horses"
signularanimal = "Horse"
SpeciesNamePlural ="Horses"
SpeciesID = 5
BreedIcon = "/icons/HorseIconwhite.png"
currentbreed="Equines"
currentbreed2 = "Horses"
end if 
if  lcase(PageName)="goats" then
PageName="Goats"
signularanimal = "Goat"
SpeciesNamePlural ="Goats"
SpeciesID = 6
BreedIcon = "/icons/GoatIconwhite.png"
currentbreed="Goats"
currentbreed2 = "Goats"
end if 
if  lcase(PageName)="donkeys" then
PageName="Donkeys"
signularanimal = "Donkey"
SpeciesNamePlural ="Donkeys"
SpeciesID = 7
BreedIcon = "/icons/DonkeyIconwhite.png"
currentbreed="Equines"
currentbreed2 = "Donkeys"
end if 
if  lcase(PageName)="cattle" then
PageName="Cattle" 
signularanimal = "Cattle"
SpeciesNamePlural ="Cattle"
SpeciesID = 8
BreedIcon = "/icons/CattleIconwhite.png"
currentbreed="Bovines"
currentbreed2 = "Cattle"
end if 
if  lcase(PageName)="bison" then
PageName="Bison"
signularanimal = "Bison"
SpeciesID = 9
BreedIcon = "/icons/buffaloIconwhite.png"
currentbreed="Bovines"
currentbreed2 = "Bison"
end if 

if  lcase(PageName)="yaks" then
PageName="Yaks"
signularanimal = "Yaks"
SpeciesID = 17
BreedIcon = "/icons/yakiconwhite.png"
currentbreed="Bovines"
currentbreed2 = "Yaks"
end if 

if  lcase(PageName)="sheep" then 
PageName="Sheep" 
signularanimal = "Sheep"
SpeciesNamePlural = "Sheep"
SpeciesID = 10
BreedIcon = "/icons/SheepIconwhite.png"
currentbreed="Sheep"
currentbreed2 = "Sheep"
end if 
if  lcase(PageName)="rabits" then
PageName="Rabits"
signularanimal = "Rabbit"
SpeciesNamePlural = "Rabbits"
SpeciesID = 11
BreedIcon = "/icons/RabbitIconwhite.png"
currentbreed="Rabbits"
currentbreed2 = "Rabbits"
end if 
if  lcase(PageName)="pigs" then
PageName="Pigs"
signularanimal = "Pig"
SpeciesNamePlural = "Pigs"
SpeciesID = 12
BreedIcon = "/icons/PigsIconwhite.png"
currentbreed="Pigs"
currentbreed2 = "Pigs"
end if 
if  lcase(PageName)="chickens" then
PageName="Chickens" 
signularanimal = "Chicken"
SpeciesNamePlural ="Chickens"
BreedIcon = "/icons/chickenIconwhite.png"
SpeciesID = 13
currentbreed2 = "Chickens"
end if 
if  lcase(PageName)="turkeys" then
PageName="Turkeys" 
signularanimal = "Turkey"
SpeciesNamePlural = "Turkeys"
SpeciesID = 14
BreedIcon = "/icons/TurkeyIconwhite.png"
currentbreed2 = "Turkeys"
end if 
if  lcase(PageName)="ducks" then
PageName="Ducks" 
signularanimal = "Duck"
SpeciesNamePlural = "Ducks"
SpeciesID = 15
BreedIcon = "/icons/DuckIconwhite.png"
currentbreed2 = "Ducks"
end if 

SpeciesName = signularanimal

Current2 = PageName %>