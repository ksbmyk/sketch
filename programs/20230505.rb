$base = 80
def setup
  createCanvas(800, 800)
  colorMode(RGB)
  angleMode(DEGREES)
  background(255, 255, 255)
  noStroke
end

def draw
  noLoop

  fill(186, 8, 61)
  arc($base , $base , $base * 2, $base * 2, 0, 360) 

  fill(155, 155, 155)  
  a =  random(5).to_i
  if (a == 1 || a== 2)
    arc($base  * 3, $base , $base * 2, $base * 2,  a * 90,  a * 90 + 90)
  else  
    arc($base  * 2, $base , $base * 2, $base * 2, a * 90,  a * 90 + 90)  
  end

  a =  random(5).to_i
  if (a == 1 || a== 2)
    arc($base  * 4, $base , $base * 2, $base * 2,  a * 90,  a * 90 + 90)
  else  
    arc($base  * 3, $base , $base * 2, $base * 2, a * 90,  a * 90 +  90)  
  end

  fill(51, 51, 51)
  a =  random(5).to_i
  arc($base  * 5,  $base , $base * 2, $base * 2,  a * 90,  a * 90 + 180) 

  fill(51, 51, 51)
  a =  random(5).to_i
  arc($base ,  $base  * 3 , $base * 2, $base * 2,  a * 90,  a * 90 + 180) 

  fill(186, 8, 61)
  arc($base *3, $base  * 3,  $base * 2, $base * 2, 0, 360) 

  fill(155, 155, 155)  
  a =  random(5).to_i
  if (a == 1 || a== 2)
    arc($base  * 5, $base  * 3 , $base * 2, $base * 2,  a * 90,  a * 90 + 90)
  else  
    arc($base  * 4, $base  * 3 , $base * 2, $base * 2, a * 90,  a * 90 + 90)  
  end

  a =  random(5).to_i
  if (a == 1 || a== 2)
    arc($base  * 6, $base  * 3 , $base * 2, $base * 2,  a * 90,  a * 90 + 90)
  else  
    arc($base  * 5, $base  * 3 , $base * 2, $base * 2, a * 90,  a * 90 +  90)  
  end
end
