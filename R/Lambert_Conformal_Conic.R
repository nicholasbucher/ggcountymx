# Lambert conformal conic projection to latitude longitude
# Weisstein, Eric W. "Lambert Conformal Conic Projection."
# From MathWorld--A Wolfram Web Resource.
# http://mathworld.wolfram.com/LambertConformalConicProjection.html


LCC_LonLat<-function(x,y){

cosg<-function(x){cos(x*2*pi/360)}
sing<-function(x){sin(x*2*pi/360)}
tang<-function(x){sing(x)/cosg(x)}
secg<-function(x){1/cosg(x)}
cosecg<-function(x){1/sing(x)}
cotg<-function(x){1/tang(x)}


# MEXICO_ITRF_2008_LCC
  R<-2500000
  phi1<-17.5
  phi2<-29.5
  phi0<-12.0
  lambda0<--102.0


#  phi1 = 33
#  phi2= 45
#  phi0 = 23
#  lambda0 = 96
#  x = 0.2966785
#  y = 0.2462112

n = log(cosg(phi1)/cosg(phi2))/log(tang((45)+(phi2/2))*cotg(45+(phi1/2)))
F = (cosg(phi1)*tang(45+(phi1/2))^n)/n
rho0 = R*F*cotg(45+(phi0/2))^n


rho = sign(n)*sqrt(x^2+(rho0-y)^2)

sigma = (atan(x/(rho0-y))*360)/(2*pi)

lambda =  - sigma/n -lambda0
phi = 2*(atan(R*F/rho)^(1/n)*360/(2*pi)) - 90
#lambda = sigma/n -lambda0
return(c(lambda,phi))
}


