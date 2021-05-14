using Pkg; Pkg.activate(".")
using Luxor, Colors

function chemellia_old(loc::Point, size::Real; petalcolor="plum3", period=16pi, step=0.5)
    for pt in reverse(spiral(size, 1.3, period=period, stepby=step))
        rad = distance(loc, loc+pt)
        blendstart = between(loc, loc+pt, 0.7)
        blendend = between(loc, loc+pt, 1.4)
        setblend(blend(blendstart, blendend, petalcolor, "white"))
        circle(loc+pt, size+0.37*rad, :fill)
    end
end

# thanks to cormullion!
function chemellia(loc::Point=O;size::Real=110, npetals=105, petalcolor="maroon")
    origin(loc)
    #sethue(petalcolor)
    setline(0.75)
    #squircle(O, 2*size, 2*size, :fill, rt = 0.3)
    #for n in 110:-1:5
    local totalrot = 0
    for n in range(size, 5, length=npetals)
        rotate(deg2rad(137.5))
        totalrot = totalrot+137.5
        petal = makebezierpath([ngon(O, n, 3, 0, vertices=true)...], smoothing=1.2)
        @layer begin
            translate(n, 0)
            setblend(blend(O, O + (n, 0),  petalcolor, "white"))
            drawbezierpath(petal, :fill)
            sethue("grey40")
            drawbezierpath(petal, :stroke)
        end
    end
    rotate(deg2rad(-totalrot%360))
end

function bee(loc::Point, size::Real; aspect=1.6, angle=0)
    rotate(angle)
    ellipse(loc, aspect*size, size, :clip)
    sethue("gold")
    for f=-0.5aspect:0.4*aspect:0.5*aspect
        rect(loc+f.*(size,0)-(0,0.5*size), aspect/5*size, size, :fill)
    end
    sethue("black")
    for f=-0.3*aspect:0.4*aspect:0.3*aspect
        rect(loc+f.*(size,0)-(0,0.5*size), aspect/5*size, size, :fill)
    end
    clipreset()
    f1 = loc + 0.4*size .* (0,-2.5)
    f2 = loc + 0.4*size .* (-1.5,-1.5)
    f3 = loc + 0.4*size .* (1.5,-1.5)
    sethue("lightgrey")
    ellipse(f1, f2, 0.3*size, :fill)
    ellipse(f1, f3, 0.3*size, :fill)
end

configs = [Dict("font"=>"Josefin Sans Semibold", "fontsize"=>110,
                "beecoords"=>(217,-115), "name"=>"josefin"),
           Dict("font"=>"Amaranth Regular", "fontsize"=>120,
                "beecoords"=>(213,-124 ), "name"=>"amaranth"),
           Dict("font"=>"Arima Madurai Bold", "fontsize"=>120,
                "beecoords"=>(241,-139), "name"=>"arima"),
            ]

config = configs[1]

Drawing(500, 500, "./squarelogo.png")    
origin()
sethue("olivedrab")
setline(0.75)
squircle(O, 240, 240, :fill, rt = 0.3)
chemellia(O + Point(250, 250), size=110)
finish()

Drawing(800,  320, "./biglogo.png")    
origin()
fontface(config["font"])
fontsize(config["fontsize"])
setcolor("olivedrab")
text("Chemellia", Point(-180,0), valign=:middle)
bee(Point(config["beecoords"]...), 20, aspect=1.5, angle=π/8)
chemellia(Point(110,160),size=45)
finish()

# for config in configs
#     for bgd in ["white","black"]
#         Drawing(800,  320, "./samples/biglogo/$(config["name"])_$bgd.png")    
#         origin()
#         background(bgd)
#         fontface(config["font"])
#         fontsize(config["fontsize"])
#         setcolor("olivedrab")
#         text("Chemellia", Point(-180,0), valign=:middle)
#         bee(Point(config["beecoords"]...), 20, aspect=1.5, angle=π/8)
#         chemellia(Point(110,160),size=45)
#         finish()
#     end
# end

# for bgd in ["white","black"]
#     Drawing(500, 500, "./samples/littlebox/on$bgd.png")    
#     origin()
#     background(bgd)
#     sethue("olivedrab")
#     setline(0.75)
#     squircle(O, 240, 240, :fill, rt = 0.3)
#     chemellia(O+Point(250,250),size=110)
#     finish()
# end

# @draw begin
#     origin()
#     background("white")
#     sethue("olivedrab")
#     setline(0.75)
#     squircle(O, 240, 240, :fill, rt = 0.3)
#     chemellia(O+Point(300,300),size=110)
# end
