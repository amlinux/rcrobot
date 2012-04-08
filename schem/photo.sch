v 20100214 2
C 40000 40000 0 0 0 title-B.sym
T 47200 50300 9 10 1 0 0 0 1
Photosensor subsystem
C 47700 48900 1 0 0 resistor-1.sym
{
T 48000 49300 5 10 0 0 0 0 1
device=RESISTOR
T 47900 49100 5 10 1 1 0 0 1
refdes=R2
T 48300 49100 5 10 1 1 0 0 1
value=1M
T 47700 48900 5 10 0 1 0 0 1
footprint=1206
}
C 47700 48400 1 0 0 resistor-1.sym
{
T 48000 48800 5 10 0 0 0 0 1
device=RESISTOR
T 47900 48600 5 10 1 1 0 0 1
refdes=R3
T 48300 48600 5 10 1 1 0 0 1
value=1M
T 47700 48400 5 10 0 1 0 0 1
footprint=1206
}
C 47700 47900 1 0 0 resistor-1.sym
{
T 48000 48300 5 10 0 0 0 0 1
device=RESISTOR
T 47900 48100 5 10 1 1 0 0 1
refdes=R4
T 48300 48100 5 10 1 1 0 0 1
value=1M
T 47700 47900 5 10 0 1 0 0 1
footprint=1206
}
C 47700 47400 1 0 0 resistor-1.sym
{
T 48000 47800 5 10 0 0 0 0 1
device=RESISTOR
T 47900 47600 5 10 1 1 0 0 1
refdes=R5
T 48300 47600 5 10 1 1 0 0 1
value=1M
T 47700 47400 5 10 0 1 0 0 1
footprint=1206
}
N 48600 49000 49400 49000 4
{
T 49500 48900 5 10 1 1 0 0 1
netname=PHOTO_IN1
}
N 48600 48500 49400 48500 4
{
T 49500 48400 5 10 1 1 0 0 1
netname=PHOTO_IN2
}
N 48600 48000 49400 48000 4
{
T 49500 47900 5 10 1 1 0 0 1
netname=PHOTO_IN3
}
N 48600 47500 49400 47500 4
{
T 49500 47400 5 10 1 1 0 0 1
netname=PHOTO_IN4
}
N 47700 49000 47000 49000 4
{
T 46000 48900 5 10 1 1 0 0 1
netname=PHOTO1+
}
N 47700 48500 47000 48500 4
{
T 46000 48400 5 10 1 1 0 0 1
netname=PHOTO2+
}
N 47700 48000 47000 48000 4
{
T 46000 47900 5 10 1 1 0 0 1
netname=PHOTO3+
}
N 47700 47500 47000 47500 4
{
T 46000 47400 5 10 1 1 0 0 1
netname=PHOTO4+
}
