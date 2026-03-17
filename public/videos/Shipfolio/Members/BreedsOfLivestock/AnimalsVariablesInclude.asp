<% 
SCRIPT_NAME = Request.ServerVariables("SCRIPT_NAME")

LastSlashPos = InStrRev(SCRIPT_NAME, "/")

DirectoryPath = Left(SCRIPT_NAME, LastSlashPos - 1)

SecondLastSlashPos = InStrRev(DirectoryPath, "/")

PageName = Right(DirectoryPath, Len(DirectoryPath) - SecondLastSlashPos)


str1 = PageName
str2 = " "
If InStr(str1,str2) > 0 Then
PageName= Replace(str1,  str2, " ")
End If  

if lcase(PageName)="alpacas" then
PageName="Alpacas" 
signularanimal = "Alpaca"
SpeciesNamePlural ="Alpacas"
SpeciesID = 2
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/AlpacaIcongrey.png"
CurrentBreed = "Alpacas"
currentbreed2 = "Alpacas"
end if 

if lcase(PageName)="alligators" then
PageName="crocodile & alligator" 
signularanimal = "crocodile & alligator"
SpeciesNamePlural ="crocodiles & alligators"
SpeciesID = 25
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/AlligatorIcongrey.png"
CurrentBreed = "Crocodiles & Alligators"
currentbreed2 = "Crocodiles & Alligators"
end if 

if lcase(PageName)="deer" then
PageName="Deer" 
signularanimal = "Deer"
SpeciesNamePlural ="Deer"
SpeciesID = 21
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/DeerIcongrey.png"
CurrentBreed = "Deer"
currentbreed2 = "Deer"
end if 


if lcase(PageName)="elk" then
PageName="Elk" 
signularanimal = "Elk"
SpeciesNamePlural ="Elk"
SpeciesID = 20
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/ElkIcongrey.png"
CurrentBreed = "Elk"
currentbreed2 = "Elk"
end if 



if lcase(PageName)="emu" then
PageName="Emu" 
signularanimal = "Emu"
SpeciesNamePlural ="Emus"
SpeciesID = 19
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/emuicongrey.png"
CurrentBreed = "Emus"
currentbreed2 = "Emus"
end if 



if lcase(PageName)="guineafowl" then
PageName="Guinea Fowl" 
signularanimal = "Guinea Fowl"
SpeciesNamePlural ="Guinea Fowl"
SpeciesID = 26
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/GuineaFowlicongrey.png"
CurrentBreed = "Guinea Fowl"
currentbreed2 = "Guinea Fowl"
end if 

if lcase(PageName)="geese" then
PageName="Geese" 
signularanimal = "Goose"
SpeciesNamePlural ="Geese"
SpeciesID = 22
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/Geeseicongrey.png"
CurrentBreed = "Geese"
currentbreed2 = "Geese"
end if 


if lcase(PageName)="muskox" then
PageName="MuskOx" 
signularanimal = "MuskOx"
SpeciesNamePlural ="MuskOx"
SpeciesID = 27
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/MuskOxicongrey.png"
CurrentBreed = "MuskOx"
currentbreed2 = "MuskOx"
end if 



if lcase(PageName)="ostriches" then
PageName="Ostriches" 
signularanimal = "Ostriches"
SpeciesNamePlural ="Ostriches"
SpeciesID = 28
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/OstricheIcongrey.png"
CurrentBreed = "Ostriches"
currentbreed2 = "Ostriches"
end if 


if lcase(PageName)="pheasants" then
PageName="Pheasants" 
signularanimal = "Pheasants"
SpeciesNamePlural ="Pheasants"
SpeciesID = 29
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/PheasantIcongrey.png"
CurrentBreed = "Pheasants"
currentbreed2 = "Pheasants"
end if 

if lcase(PageName)="pigeons" then
PageName="Pigeons" 
signularanimal = "Pigeons"
SpeciesNamePlural ="Pigeons"
SpeciesID = 30
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/PigeonIcongrey.png"
CurrentBreed = "Pigeons"
currentbreed2 = "Pigeons"
end if 

if lcase(PageName)="quails" then
PageName="Quails" 
signularanimal = "Quail"
SpeciesNamePlural ="Quail"
SpeciesID = 31
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/QuailIcongrey.png"
CurrentBreed = "Quail"
currentbreed2 = "Quail"
end if 

if lcase(PageName)="reindeer" then
PageName="Reindeer" 
signularanimal = "Reindeer"
SpeciesNamePlural ="Reindeer"
SpeciesID = 32
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/ReindeerIcongrey.png"
CurrentBreed = "Reindeer"
currentbreed2 = "Reindeer"
end if 

if lcase(PageName)="snails" then
PageName="Snails" 
signularanimal = "Snail"
SpeciesNamePlural ="Snails"
SpeciesID = 33
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/SnailIcongrey.png"
CurrentBreed = "Snails"
currentbreed2 = "Snails"
end if 




if lcase(PageName)="camels" then
PageName="Camels" 
signularanimal = "Camel"
SpeciesNamePlural ="Camels"
SpeciesID = 18
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/CamelsIcongrey.png"
CurrentBreed = "Camels"
currentbreed2 = "Camels"
end if 


if lcase(PageName)="ducks" then
PageName="Ducks" 
signularanimal = "Duck"
SpeciesNamePlural ="Duck"
SpeciesID = 15
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/Duckicongrey.png"
CurrentBreed = "Ducks"
currentbreed2 = "Ducks"
end if 


if lcase(PageName)="geese" then
PageName="Geese" 
signularanimal = "Goose"
SpeciesNamePlural ="Goose"
SpeciesID = 22
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/Gooseicongrey.png"
CurrentBreed = "Geese"
currentbreed2 = "Geese"
end if 


if  lcase(PageName)="dogs" then
PageName="Dogs"
signularanimal = "Dog"
SpeciesNamePlural ="Dogs"
SpeciesID = 3
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/DogIcongrey.png"
currentbreed="Dogs"
currentbreed2 = "Dogs"
end if 
if  lcase(PageName)="llamas" then
PageName="Llamas"
signularanimal = "Llamas"
SpeciesNamePlural ="Llamas"
SpeciesID = 4
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/LlamaIcongrey.png"
currentbreed="Llamas"
currentbreed2 = "Llamas"
end if 
if  lcase(PageName)="horses" then
PageName="Horses"
signularanimal = "Horse"
SpeciesNamePlural ="Horses"
SpeciesID = 5
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/HorseIcongrey.png"
currentbreed="Horses"
currentbreed2 = "Horses"
end if 
if  lcase(PageName)="goats" then
PageName="Goats"
signularanimal = "Goat"
SpeciesNamePlural ="Goats"
SpeciesID = 6
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/GoatIcongrey.png"
currentbreed="Goats"
currentbreed2 = "Goats"
end if 
if  lcase(PageName)="donkeys" then
PageName="Donkeys"
signularanimal = "Donkey"
SpeciesNamePlural ="Donkeys"
SpeciesID = 7
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/DonkeyIcongrey.png"
currentbreed="Donkeys"
currentbreed2 = "Donkeys"
end if 
if  lcase(PageName)="cattle" then
PageName="Cattle" 
signularanimal = "Cattle"
SpeciesNamePlural ="Cattle"
SpeciesID = 8
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/CattleIcongrey.png"
currentbreed="Cattle"
currentbreed2 = "Cattle"
end if 
if  lcase(PageName)="bison" then
PageName="Bison"
signularanimal = "Bison"
SpeciesID = 9
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/buffaloIcongrey.png"
currentbreed="Bison"
currentbreed2 = "Bison"
end if 

if  lcase(PageName)="buffalo" then
PageName="Buffalo"
signularanimal = "Buffalo"
SpeciesID = 34
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/WaterBuffaloicongrey.png"
currentbreed="Buffalo"
currentbreed2 = "Buffalo"
end if 


if  lcase(PageName)="yaks" then
PageName="Yaks"
signularanimal = "Yaks"
SpeciesID = 17
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/YakIcongrey.png"
currentbreed="Yaks"
currentbreed2 = "Yaks"
end if 

if  lcase(PageName)="sheep" then 
PageName="Sheep" 
signularanimal = "Sheep"
SpeciesNamePlural = "Sheep"
SpeciesID = 10
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/SheepIcongrey.png"
currentbreed="Sheep"
currentbreed2 = "Sheep"
end if 
if  lcase(PageName)="rabbits" then
PageName="Rabits"
signularanimal = "Rabbit"
SpeciesNamePlural = "Rabbits"
SpeciesID = 11
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/RabbitIcongrey.png"
currentbreed="Rabbits"
currentbreed2 = "Rabbits"
end if 
if  lcase(PageName)="pigs" then
PageName="Pigs"
signularanimal = "Pig"
SpeciesNamePlural = "Pigs"
SpeciesID = 12
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/PigsIcongrey.png"
currentbreed="Pigs"
currentbreed2 = "Pigs"
end if 
if  lcase(PageName)="chickens" then
PageName="Chickens" 
signularanimal = "Chicken"
SpeciesNamePlural ="Chickens"
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/chickenIcongrey.png"
SpeciesID = 13
currentbreed="Chickens"
currentbreed2 = "Chickens"
end if 
if  lcase(PageName)="turkeys" then
PageName="Turkeys" 
signularanimal = "Turkey"
SpeciesNamePlural = "Turkeys"
SpeciesID = 14
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/TurkeyIcongrey.png"
currentbreed="Turkeys"
currentbreed2 = "Turkeys"
end if 
if  lcase(PageName)="ducks" then
PageName="Ducks" 
signularanimal = "Duck"
SpeciesNamePlural = "Ducks"
SpeciesID = 15
BreedIcon = "https://www.OatmealFarmNetwork.com/icons/DuckIcongrey.png"
currentbreed="Ducks"
currentbreed2 = "Ducks"
end if 
if  lcase(PageName)="honeybees" then
PageName="HoneyBees" 
signularanimal = "Honey Bee"
SpeciesNamePlural = "Honey Bees"
SpeciesID = 23
BreedIcon = "/icons/HoneyBeesicongrey.png"
currentbreed2 = "Honey Bees"
end if 

SpeciesName = signularanimal

Current2 = PageName %>