#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/host-firmware.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/host-firmware.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/crc.p1 ${OBJECTDIR}/_ext/1493717523/radio.p1 ${OBJECTDIR}/rchost.p1 ${OBJECTDIR}/usart.p1
POSSIBLE_DEPFILES=${OBJECTDIR}/crc.p1.d ${OBJECTDIR}/_ext/1493717523/radio.p1.d ${OBJECTDIR}/rchost.p1.d ${OBJECTDIR}/usart.p1.d

# Object Files
OBJECTFILES=${OBJECTDIR}/crc.p1 ${OBJECTDIR}/_ext/1493717523/radio.p1 ${OBJECTDIR}/rchost.p1 ${OBJECTDIR}/usart.p1


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/host-firmware.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=16F1518
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/crc.p1: crc.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 crc.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  crc.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/crc.p1: > ${OBJECTDIR}/crc.p1.d
	@cat ${OBJECTDIR}/crc.dep >> ${OBJECTDIR}/crc.p1.d
	@${FIXDEPS} "${OBJECTDIR}/crc.p1.d" $(SILENT) -ht 
	
${OBJECTDIR}/_ext/1493717523/radio.p1: ../robot-firmware/radio.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1493717523 
	${MP_CC} --pass1 ../robot-firmware/radio.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}/_ext/1493717523" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  ../robot-firmware/radio.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}/_ext/1493717523" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/_ext/1493717523/radio.p1: > ${OBJECTDIR}/_ext/1493717523/radio.p1.d
	@cat ${OBJECTDIR}/_ext/1493717523/radio.dep >> ${OBJECTDIR}/_ext/1493717523/radio.p1.d
	@${FIXDEPS} "${OBJECTDIR}/_ext/1493717523/radio.p1.d" $(SILENT) -ht 
	
${OBJECTDIR}/rchost.p1: rchost.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 rchost.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  rchost.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/rchost.p1: > ${OBJECTDIR}/rchost.p1.d
	@cat ${OBJECTDIR}/rchost.dep >> ${OBJECTDIR}/rchost.p1.d
	@${FIXDEPS} "${OBJECTDIR}/rchost.p1.d" $(SILENT) -ht 
	
${OBJECTDIR}/usart.p1: usart.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 usart.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  usart.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/usart.p1: > ${OBJECTDIR}/usart.p1.d
	@cat ${OBJECTDIR}/usart.dep >> ${OBJECTDIR}/usart.p1.d
	@${FIXDEPS} "${OBJECTDIR}/usart.p1.d" $(SILENT) -ht 
	
else
${OBJECTDIR}/crc.p1: crc.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 crc.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  crc.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/crc.p1: > ${OBJECTDIR}/crc.p1.d
	@cat ${OBJECTDIR}/crc.dep >> ${OBJECTDIR}/crc.p1.d
	@${FIXDEPS} "${OBJECTDIR}/crc.p1.d" $(SILENT) -ht 
	
${OBJECTDIR}/_ext/1493717523/radio.p1: ../robot-firmware/radio.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/1493717523 
	${MP_CC} --pass1 ../robot-firmware/radio.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}/_ext/1493717523" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  ../robot-firmware/radio.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}/_ext/1493717523" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/_ext/1493717523/radio.p1: > ${OBJECTDIR}/_ext/1493717523/radio.p1.d
	@cat ${OBJECTDIR}/_ext/1493717523/radio.dep >> ${OBJECTDIR}/_ext/1493717523/radio.p1.d
	@${FIXDEPS} "${OBJECTDIR}/_ext/1493717523/radio.p1.d" $(SILENT) -ht 
	
${OBJECTDIR}/rchost.p1: rchost.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 rchost.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  rchost.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/rchost.p1: > ${OBJECTDIR}/rchost.p1.d
	@cat ${OBJECTDIR}/rchost.dep >> ${OBJECTDIR}/rchost.p1.d
	@${FIXDEPS} "${OBJECTDIR}/rchost.p1.d" $(SILENT) -ht 
	
${OBJECTDIR}/usart.p1: usart.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	${MP_CC} --pass1 usart.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@${MP_CC} --scandep  usart.c $(MP_EXTRA_CC_PRE) -q --chip=$(MP_PROCESSOR_OPTION) -P  --outdir="${OBJECTDIR}" -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9 --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --opt=default,+asm,-asmfile,+speed,-space,-debug,-9  --double=24 --float=24 --addrqual=ignore --mode=lite -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s"
	@echo ${OBJECTDIR}/usart.p1: > ${OBJECTDIR}/usart.p1.d
	@cat ${OBJECTDIR}/usart.dep >> ${OBJECTDIR}/usart.p1.d
	@${FIXDEPS} "${OBJECTDIR}/usart.p1.d" $(SILENT) -ht 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/host-firmware.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) -odist/${CND_CONF}/${IMAGE_TYPE}/host-firmware.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  -mdist/${CND_CONF}/${IMAGE_TYPE}/host-firmware.${IMAGE_TYPE}.map --summary=default,-psect,-class,+mem,-hex --chip=$(MP_PROCESSOR_OPTION) -P --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D__DEBUG --debugger=pickit3 -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9  --double=24 --float=24 --addrqual=ignore --mode=lite --output=default,-inhx032 -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s" ${OBJECTFILES_QUOTED_IF_SPACED}  
	@${RM} dist/${CND_CONF}/${IMAGE_TYPE}/host-firmware.${IMAGE_TYPE}.hex
else
dist/${CND_CONF}/${IMAGE_TYPE}/host-firmware.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) -odist/${CND_CONF}/${IMAGE_TYPE}/host-firmware.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  -mdist/${CND_CONF}/${IMAGE_TYPE}/host-firmware.${IMAGE_TYPE}.map --summary=default,-psect,-class,+mem,-hex --chip=$(MP_PROCESSOR_OPTION) -P --runtime=default,+clear,+init,-keep,+osccal,-resetbits,-download,-stackcall,+clib --summary=default,-psect,-class,+mem,-hex --opt=default,+asm,-asmfile,+speed,-space,-debug,-9 -D_XTAL_FREQ=16000000 -DRADIO_EN_ANSEL=ANSELB -DRADIO_EN_TRIS=TRISB -DRADIO_EN_LAT=LATB -DRADIO_TXRX_ANSEL=ANSELB -DRADIO_TXRX_TRIS=TRISB -DRADIO_TXRX_LAT=LATB -DRADIO_SND_ANSEL=ANSELC -DRADIO_SND_TRIS=TRISC -DRADIO_SND_LAT=LATC -DRADIO_RCV_ANSEL=ANSELC -DRADIO_RCV_TRIS=TRISC -DRADIO_RCV_PORT=PORTC -DRADIO_EN_BIT=5 -DRADIO_TXRX_BIT=4 -DRADIO_SND_BIT=4 -DRADIO_RCV_BIT=5 -N31 --warn=9  --double=24 --float=24 --addrqual=ignore --mode=lite --output=default,-inhx032 -g --asmlist "--errformat=%f:%l: error: %s" "--msgformat=%f:%l: advisory: %s" "--warnformat=%f:%l warning: %s" ${OBJECTFILES_QUOTED_IF_SPACED}  
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell "${PATH_TO_IDE_BIN}"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
