C(x)=((x^2+1.)^0.5+x)^2
Shmin(Sv,Pp,μ)=((Sv-Pp)/C(μ))+Pp
Shmax(Sv,Pp,μ)=C(μ)*(Sv-Pp)+Pp


@userplot zobackogram

@recipe function f(h::zobackogram)

    Sv, Pp, μ = h.args

    Smin=Shmin(Sv,Pp,μ)
    Smax=Shmax(Sv,Pp,μ)

    #45° line. slope=1
    L1=[0,Smax*1.1]

    #Shmin line
    L2=[Smin Smin;Smin Sv]

    #Shmax Horizonal line
    L3=[Sv Smax;Smax Smax]

    #Shmax diagonal Line
    L4=[Smin Sv;Sv Smax]

    #Internal Lines
    L5=[Smin Sv; Sv Sv;Sv Smax]

    xlabel := "Shmin [psi/ft]"
    ylabel := "Shmax [psi/ft]"
    legend := :bottomright
    legendfontsize --> 6

    #45° line. slope=1
    @series begin
        seriestype := :path
        linewidth := 3
        linecolor := :black
        label := "45° Line"
        L1,L1
    end

    @series begin
        seriestype := :path
        linewidth := 2
        linecolor := :darkblue
        label := "Shmin Line"
        L2[:,1],L2[:,2]
    end

    @series begin
        seriestype := :path
        linewidth := 2
        linecolor := :darkred
        label := "Shmax Horizontal Line"
        L3[:,1],L3[:,2]
    end

    @series begin
        seriestype := :path
        linewidth := 2
        linecolor := :darkgreen
        label := "Shmax Strike Slip"
        L4[:,1],L4[:,2]
    end

    @series begin
        seriestype := :path
        linewidth := 1
        linestyle := :dash
        linecolor := :black
        label := "Limits"
        series_annotations := map(x->Plots.text(x ,:left,:top,6),["Shmin=$(round(Smin,digits=1))",
                                "Sv=$(round(Sv,digits=1))","Shmax=$(round(Smax,digits=1))"])
        L5[:,1],L5[:,2]
    end

end
