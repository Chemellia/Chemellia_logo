using Luxor

Drawing(500,  130, "/tmp/alchemy.svg")
origin()
setmesh(mesh(convert(Vector{Point}, BoundingBox() * 0.9), ["#fae698", "#b8a24b", "grey30", "gold1", ]))

box(O, 450, 120, 20, :fillpreserve)
sethue("black")
setline(5)
box(O, 450, 120, 20, :stroke)
setline(2)
box(O, 435, 105, 20, :stroke)

fontface("Archer-Bold")
fontsize(130)
text("AI", boxmiddleleft(BoundingBox()) + (50, 0), valign=:middle)

fontsize(90)
text("chemy", boxmiddlecenter(BoundingBox()) + (-60, -8.5), halign=:left, valign=:middle)

translate(-70, 29.5) # move to top right foot of "I"

bx = box(O, O + (245, 13.25), vertices=true)
bx[3] = bx[3] - (10, 0)
poly(bx, :fill)

@layer begin
    transform([1, 0, -tan(π/12), 1, 0, 0])
    for (n, pt) in enumerate(between.(O + (10, 0), O + (160, 0), 0:0.5:1))
        @layer begin
            translate(pt)
            sethue([Luxor.julia_red, Luxor.julia_green, Luxor.julia_purple, Luxor.julia_blue][mod1(n, end)])
            box(O, O + (65, 13.25), :fill)
        end
    end
end

finish()
preview()
