#using Pkg; Pkg.activate("./")
#using Luxor

@draw begin
    origin()

    #sethue(Luxor.julia_red)
    fontface("Tamil MN Bold")
    fontsize(130)
    text("AI", boxmiddleleft(BoundingBox()) + (50, 0), valign=:middle)

    sethue("gold1")
    fontsize(100)
    text("chem", boxmiddlecenter(BoundingBox()) + (-120, 5), halign=:left, valign=:middle)

    y_vertices = [Point(200,-25),Point(150,-25),Point(175,0),Point(175,35)]
    
    setline(5)
    sethue(Luxor.julia_red)
    vertex_pairs = [(1,3),(2,3),(3,4)]
    map(p->line(y_vertices[p[1]],y_vertices[p[2]],:stroke),vertex_pairs)
    
    sethue(Luxor.julia_blue)
    circle.(y_vertices, 12, :fill)

end