v 20100214 2
C 40000 40000 0 0 0 title-B.sym
C 46600 46600 1 0 0 LM2574N-5G.sym
{
T 48300 48700 5 10 1 1 0 6 1
refdes=U3
T 46900 49050 5 10 0 0 0 0 1
device=LM2574-5G
T 46900 49250 5 10 0 0 0 0 1
footprint=DIP8
}
N 46600 44900 46600 47800 4
N 46600 45200 47500 45200 4
N 47800 45200 48600 45200 4
N 48600 45200 48600 47000 4
N 48100 45900 48600 45900 4
N 47200 45900 46600 45900 4
C 46800 44900 1 180 0 vss-1.sym
C 49400 46900 1 90 0 diode-2.sym
{
T 48800 47300 5 10 0 0 90 0 1
device=DIODE
T 49400 47500 5 10 1 1 270 0 1
refdes=D1
T 49400 46900 5 10 0 1 180 0 1
footprint=ACY300
}
C 49300 46600 1 180 0 vss-1.sym
N 49100 46600 49100 46900 4
N 48600 47800 49300 47800 4
C 49300 47700 1 0 0 inductor-1.sym
{
T 49500 48200 5 10 0 0 0 0 1
device=INDUCTOR
T 49500 48000 5 10 1 1 0 0 1
refdes=L1
T 49500 48400 5 10 0 0 0 0 1
symversion=0.1
T 49500 48200 5 10 1 1 0 0 1
value=330uH
T 49300 47700 5 10 0 1 0 0 1
footprint=1806
}
C 50100 47800 1 270 0 capacitor-2.sym
{
T 50800 47600 5 10 0 0 270 0 1
device=POLARIZED_CAPACITOR
T 50600 47600 5 10 1 1 270 0 1
refdes=C1
T 51000 47600 5 10 0 0 270 0 1
symversion=0.1
T 50600 47200 5 10 1 1 270 0 1
value=220uF
T 50100 47800 5 10 0 1 0 0 1
footprint=RADIAL_CAN 200
}
C 50500 46600 1 180 0 vss-1.sym
N 50300 46900 50300 46600 4
N 50200 47800 50300 47800 4
N 50300 47800 50300 49100 4
N 50300 49100 46600 49100 4
N 46600 48200 46600 49400 4
C 46400 49400 1 0 0 vdd-1.sym
T 47700 49800 9 10 1 0 0 0 1
Power subsystem
C 47200 45700 1 0 0 capacitor-1.sym
{
T 47400 46400 5 10 0 0 0 0 1
device=CAPACITOR
T 47400 46200 5 10 1 1 0 0 1
refdes=C2
T 47400 46600 5 10 0 0 0 0 1
symversion=0.1
T 47800 46200 5 10 1 1 0 0 1
value=22uF
T 47200 45700 5 10 0 0 0 0 1
footprint=1206
}
C 44300 43100 1 0 0 connector2-1.sym
{
T 44500 44100 5 10 0 0 0 0 1
device=CONNECTOR_2
T 44300 43900 5 10 1 1 0 0 1
refdes=CONN2
T 44300 43100 5 10 0 1 0 0 1
footprint=CONNECTOR 2 1
}
N 47500 45200 47500 43600 4
N 47500 43600 46000 43600 4
N 47800 45200 47800 43300 4
N 47800 43300 46000 43300 4
{
T 46200 43300 5 10 1 1 0 0 1
netname=PWR_IN
}