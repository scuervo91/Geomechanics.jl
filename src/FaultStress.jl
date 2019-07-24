"""
S=[S1, S2, S3] = Magnitude of principal stresses
 Pp = Pore pressure
 mu = Coefficient of sliding friction
 a = trend of S1, except when S1 is vertical a = trend of SHmax minus 90 degrees
 b = -plunge of S1 (plunge is angle from horizontal)
 c = rake of S2, 0 if S1 or S3 is vertical, 90 if S2 is vertical
 faults = 2 column matrix with strike(0-360), dip(0-90)
          (use right-hand rule)), e.g faults=[208,60;36,62;...]
"""
function FaultStress(s,Pp,μ,a,b,c,faults)

n=size(faults,1)

str=faults[:,1].*(π./180)
dip=faults[:,2].*(π./180)
a=a*(π/180)
b=b*(π/180)
c=c*(π/180)

#Principal Stress Tensor
IM=Matrix{Float64}(I,3,3)
S=s.*IM

#Transformation from Principal Stress to Geografic Coordinates

R1=[cos(a)*cos(b) sin(a)*cos(b) -sin(b);
    cos(a)*sin(b)*sin(c)-sin(a)*cos(c) sin(a)*sin(b)*sin(c)+cos(a)*cos(c) cos(b)*sin(c);
    cos(a)*sin(b)*cos(c)+sin(a)*sin(c) sin(a)*sin(b)*cos(c)-cos(a)*sin(c) cos(b)*cos(c)]

Sg=R1'*S*R1

    Sn=zeros(n)
    τ=zeros(n)
    rake=zeros(n)
    for k=1:n

    # Transformation from geographic to fault coordinate system
    R2=[cos(str[k]) sin(str[k]) 0;
         sin(str[k])*cos(dip[k]) -cos(str[k])*cos(dip[k]) -sin(dip[k]);
         -sin(str[k])*sin(dip[k]) cos(str[k])*sin(dip[k]) -cos(dip[k])]

        Sf=R2*Sg*R2'

        Sn[k]=Sf[3,3]

        if Sf[3,2]>0.0
            rake[k]=atan(Sf[3,2]/Sf[3,1])

        elseif Sf[3,2]>0.0 && Sf[3,1]>0.0
            rake[k]=π-atan(Sf[3,2]/-Sf[3,1])
        else
            rake[k]=atan(-Sf[3,2]/-Sf[3,1])-π
        end

        R3=[cos(rake[k]) sin(rake[k]) 0;
            -sin(rake[k]) cos(rake[k]) 0;
            0 0 1]
        Sr=R3*Sf*R3'
        τ[k]=Sr[3,1]
    end
    τ=abs.(τ)
    σn=Sn.-Pp
    CFF=τ .- μ.*σn

    return σn, τ, CFF
end
