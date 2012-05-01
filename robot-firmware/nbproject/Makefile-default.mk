#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
include Makefile

# Environment
MKDIR=mkdir -p
RM=rm -f 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/robot-firmware.${IMAGE_TYPE}.cof
else
IMAGE_TYPE=production
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/robot-firmware.${IMAGE_TYPE}.cof
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/477258191/crc.p1 ${OBJECTDIR}/adc.p1 ${OBJECTDIR}/radio.p1 ${OBJECTDIR}/rcrobot.p1


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

# Path to java used to run MPLAB X when this makefile was created
MP_JAVA_PATH=/usr/lib/jvm/java-6-sun-1.6.0.26/jre/bin/
OS_CURRENT="$(shell uname -s)"
############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
MP_CC=/usr/hitech/picc/9.82/bin/picc
# MP_BC is not defined
MP_AS=/usr/hitech/picc/9.82/bin/picc
MP_LD=/usr/hitech/picc/9.82/bin/picc
MP_AR=/usr/hitech/picc/9.82/bin/picc
# MP_BC is not defined
MP_CC_DIR=/usr/hitech/picc/9.82/bin
# MP_BC_DIR is not defined
MP_AS_DIR=/usr/hitech/picc/9.82/bin
MP_LD_DIR=/usr/hitech/picc/9.82/bin
MP_AR_DIR=/usr/hitech/picc/9.82/bin
# MP_BC_DIR is not defined

.build-conf: ${BUILD_SUBPROJECTS}
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/robot-firmware.${IMAGE_TYPE}.cof

MP_PROCESSOR_OPTION=16F1518
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/radio.p1: radio.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 radio.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR} -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	${MP_CC} --scandep --pass1 radio.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR} -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	echo "${OBJECTDIR}/radio.p1:\\" > ${OBJECTDIR}/radio.p1.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@cat ${OBJECTDIR}/radio.dep | sed -e 's/^ *//' -e 's/\\/\//g' -e 's/ /\\ /g' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/radio.p1.d
else 
	@cat ${OBJECTDIR}/radio.dep | sed -e 's/^ *//' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/radio.p1.d
endif
${OBJECTDIR}/_ext/477258191/crc.p1: ../host-firmware/crc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/477258191 
	${MP_CC} --pass1 ../host-firmware/crc.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR}/_ext/477258191 -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	${MP_CC} --scandep --pass1 ../host-firmware/crc.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR}/_ext/477258191 -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	echo "${OBJECTDIR}/_ext/477258191/crc.p1:\\" > ${OBJECTDIR}/_ext/477258191/crc.p1.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@cat ${OBJECTDIR}/_ext/477258191/crc.dep | sed -e 's/^ *//' -e 's/\\/\//g' -e 's/ /\\ /g' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/_ext/477258191/crc.p1.d
else 
	@cat ${OBJECTDIR}/_ext/477258191/crc.dep | sed -e 's/^ *//' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/_ext/477258191/crc.p1.d
endif
${OBJECTDIR}/adc.p1: adc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 adc.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR} -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	${MP_CC} --scandep --pass1 adc.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR} -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	echo "${OBJECTDIR}/adc.p1:\\" > ${OBJECTDIR}/adc.p1.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@cat ${OBJECTDIR}/adc.dep | sed -e 's/^ *//' -e 's/\\/\//g' -e 's/ /\\ /g' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/adc.p1.d
else 
	@cat ${OBJECTDIR}/adc.dep | sed -e 's/^ *//' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/adc.p1.d
endif
${OBJECTDIR}/rcrobot.p1: rcrobot.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 rcrobot.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR} -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	${MP_CC} --scandep --pass1 rcrobot.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR} -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	echo "${OBJECTDIR}/rcrobot.p1:\\" > ${OBJECTDIR}/rcrobot.p1.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@cat ${OBJECTDIR}/rcrobot.dep | sed -e 's/^ *//' -e 's/\\/\//g' -e 's/ /\\ /g' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/rcrobot.p1.d
else 
	@cat ${OBJECTDIR}/rcrobot.dep | sed -e 's/^ *//' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/rcrobot.p1.d
endif
else
${OBJECTDIR}/radio.p1: radio.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 radio.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR} -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	${MP_CC} --scandep --pass1 radio.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR} -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	echo "${OBJECTDIR}/radio.p1:\\" > ${OBJECTDIR}/radio.p1.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@cat ${OBJECTDIR}/radio.dep | sed -e 's/^ *//' -e 's/\\/\//g' -e 's/ /\\ /g' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/radio.p1.d
else 
	@cat ${OBJECTDIR}/radio.dep | sed -e 's/^ *//' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/radio.p1.d
endif
${OBJECTDIR}/_ext/477258191/crc.p1: ../host-firmware/crc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR}/_ext/477258191 
	${MP_CC} --pass1 ../host-firmware/crc.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR}/_ext/477258191 -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	${MP_CC} --scandep --pass1 ../host-firmware/crc.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR}/_ext/477258191 -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	echo "${OBJECTDIR}/_ext/477258191/crc.p1:\\" > ${OBJECTDIR}/_ext/477258191/crc.p1.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@cat ${OBJECTDIR}/_ext/477258191/crc.dep | sed -e 's/^ *//' -e 's/\\/\//g' -e 's/ /\\ /g' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/_ext/477258191/crc.p1.d
else 
	@cat ${OBJECTDIR}/_ext/477258191/crc.dep | sed -e 's/^ *//' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/_ext/477258191/crc.p1.d
endif
${OBJECTDIR}/adc.p1: adc.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 adc.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR} -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	${MP_CC} --scandep --pass1 adc.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR} -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	echo "${OBJECTDIR}/adc.p1:\\" > ${OBJECTDIR}/adc.p1.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@cat ${OBJECTDIR}/adc.dep | sed -e 's/^ *//' -e 's/\\/\//g' -e 's/ /\\ /g' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/adc.p1.d
else 
	@cat ${OBJECTDIR}/adc.dep | sed -e 's/^ *//' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/adc.p1.d
endif
${OBJECTDIR}/rcrobot.p1: rcrobot.c  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 rcrobot.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR} -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	${MP_CC} --scandep --pass1 rcrobot.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir=${OBJECTDIR} -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	echo "${OBJECTDIR}/rcrobot.p1:\\" > ${OBJECTDIR}/rcrobot.p1.d
ifneq (,$(findstring MINGW32,$(OS_CURRENT))) 
	@cat ${OBJECTDIR}/rcrobot.dep | sed -e 's/^ *//' -e 's/\\/\//g' -e 's/ /\\ /g' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/rcrobot.p1.d
else 
	@cat ${OBJECTDIR}/rcrobot.dep | sed -e 's/^ *//' -e 's/^.*$$/ &\\/g'  >> ${OBJECTDIR}/rcrobot.p1.d
endif
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/robot-firmware.${IMAGE_TYPE}.cof: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) -odist/${CND_CONF}/${IMAGE_TYPE}/robot-firmware.${IMAGE_TYPE}.cof -mdist/${CND_CONF}/${IMAGE_TYPE}/robot-firmware.${IMAGE_TYPE}.map --summary=default,-psect,-class,+mem,-hex --chip=$(MP_PROCESSOR_OPTION) -P --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3 -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9  --double=24 --float=24 --addrqual=ignore --mode=lite --output=default,-inhx032 -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s" ${OBJECTFILES}  
	${RM} dist/${CND_CONF}/${IMAGE_TYPE}/robot-firmware.${IMAGE_TYPE}.hex
else
dist/${CND_CONF}/${IMAGE_TYPE}/robot-firmware.${IMAGE_TYPE}.cof: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk
	${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) -odist/${CND_CONF}/${IMAGE_TYPE}/robot-firmware.${IMAGE_TYPE}.cof -mdist/${CND_CONF}/${IMAGE_TYPE}/robot-firmware.${IMAGE_TYPE}.map --summary=default,-psect,-class,+mem,-hex --chip=$(MP_PROCESSOR_OPTION) -P --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,+stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELC -DRADIO_EN_TRIS=TRISC -DRADIO_EN_LAT=LATC -DRADIO_TXRX_ANSEL=ANSELC -DRADIO_TXRX_TRIS=TRISC -DRADIO_TXRX_LAT=LATC -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=4 -DRADIO_TXRX_BIT=5 -DRADIO_SND_BIT=6 -DRADIO_RCV_BIT=7 -DMYADDR=2 -N31 --warn=9  --double=24 --float=24 --addrqual=ignore --mode=lite --output=default,-inhx032 -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s" ${OBJECTFILES}  
endif


# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf:
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
