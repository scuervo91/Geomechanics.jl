@userplot triplot

@recipe function f(h::triplot;
                    NodeName=["A","B","C"],m=9,tlim=[0.1,0.9], Norm=false)
    x,y = h.args


    if Norm==true
       x=x./sum(x,dims=2)

    end

    N=[1 0 0;0 1 0; 0 0 1;1 0 0]
    T=[0 0;0.5 sqrt(3)/2;1 0]  # Transformation matrix

    i=x*T  # Cartesian coordinates of given data
    n=N*T  # Cartesian coordinates of nodes

#Minor grid construction

c=zeros(m,3)
a=zeros(m,3)
b=zeros(m,3)
ba=zeros(m,3)

r=range(tlim[1],stop=tlim[2],length=m)

c[:,1]=r[end:-1:1]
c[:,3]=r

a[:,2]=r
a[:,1]=r[end:-1:1]

b[:,3]=r
b[:,2]=r[end:-1:1]

ba[:,2]=r
ba[:,3]=r[end:-1:1]

A=a*T
B=b*T
C=c*T
BA=ba*T

    legend := false


   grid := false
   showaxis := false
    @series begin
            seriestype := :scatter
           markershape --> :circle
           markersize --> 5
           markercolor --> :red
            i[:,1], i[:,2]
    end

    @series begin
       seriestype := :path
       linecolor := :black
        linewidth := 2
        series_annotation := [text("$(NodeName[1])",:right),text("$(NodeName[2])",:bottom),
                                text("$(NodeName[3])",:top),text("$(NodeName[1])",:right)]
        n[:,1],n[:,2]
    end

    @series begin
        seriestype := :path
        linecolor := :gray
        linewidth := 0.5
        [A[:,1] C[:,1]]',[A[:,2] C[:,2]]'
    end

        @series begin
        seriestype := :path
        linecolor := :gray
        linewidth := 0.5
        [C[:,1] B[:,1]]',[C[:,2] B[:,2]]'
    end

            @series begin
        seriestype := :path
        linecolor := :gray
        linewidth := 0.5
        [BA[:,1] A[:,1]]',[BA[:,2] A[:,2]]'
    end
end
