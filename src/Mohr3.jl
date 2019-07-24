@userplot mohr3

@recipe function f(h::mohr3)

    S, Pp, μ, σn, τ, CFF=h.args

β=range(0,stop=π,length=180)
σ=S.-Pp

x1=((σ[1]-σ[3])/2).*cos.(β) .+ ((σ[1]+σ[3])/2)
y1=((σ[1]-σ[3])/2).*sin.(β)

x2=((σ[1]-σ[2])/2).*cos.(β) .+ ((σ[1]+σ[2])/2)
y2=((σ[1]-σ[2])/2).*sin.(β)

x3=((σ[2]-σ[3])/2).*cos.(β) .+ ((σ[2]+σ[3])/2)
y3=((σ[2]-σ[3])/2).*sin.(β)

X=[x1 x2 x3]
Y=[y1 y2 y3]


σl=[0,0.8*σ[1]]
fr=σl.*μ

c=range(RGB(0.0,1.0,0.0),stop=RGB(0.5,1.0,1.0),length=size(σn,1))
cg=ColorGradient(c)

    xlabel --> "Normal Stress"
    ylabel --> "Shear Stress"
    legend := false
    aspect_ratio := :equal
    colorbar:= :top
    colorbar_title:= "CFF"

    @series begin
        seriestype := :path
        linecolor := :black
        linewidth := 1

        X, Y
    end

    @series begin
        seriestype := :scatter
        marker_z := CFF
        markercolor := cg
        σn, τ
    end

    @series begin
        seriestype := :path
        linestyle := :dash
        linewidth := 1
        linecolor := :red

        σl, fr
    end
end
