# つぶやきprocessing用
# draw=e=>{
# frameRate(10),createCanvas(W=500,W),r=random
# for(i=1;i<=200;i++){c=color(r(W/2),r(W),255)
# if(frameCount%2===0){noStroke(),fill(c)}else{stroke(c),fill(r(W/2),r(W),255)}
# rect(r(W),r(W),30)}}//#つぶやきprocessing

def draw
    w = 500
    createCanvas(w, w)
    frameRate(10)
    background(255)
    200.times do | i |
        c = color(rand(w / 2), rand(w), 255)
        if i.even?
            noStroke
            fill(c)
        else 
            stroke(c)
            fill(rand(w), rand(w),255)
        end
        rect(rand(w), rand(w), 30)
    end
end
