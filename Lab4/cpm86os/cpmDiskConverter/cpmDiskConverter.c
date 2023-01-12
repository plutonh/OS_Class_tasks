#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// #include <io.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
/*
The track ordering is causing problems when using disk images for VMWare.
VMWare expects to have the tracks arranged C0H0, C0H1, C1H0, C1H1, C2H0, C2H1, ... 
Cpmtools doesn't care about cylinders or heads; it just writes
tracks, so a disk image written by cpmtools ends up C0H0, C1H0, C2H0, C3H0, ...

Converting a disk image from VMWare to cpmtools needs option "vmw-to-cpmt"
Converting a disk image from cpmtools to VMWare needs option "cpmt-to-vmw"

Visit my blog at http://www.z80.eu/blog/ for more infos, Peter Dassow 08-2012
*/

#define SECTORSIZE 512
#define SECSPERTRACK 18
#define TRACKSPERSIDE 80

#define VM_TO_TOOLS 1
#define TOOLS_TO_VM 0

// typedef char bool;

int inFile,outFile;
unsigned char buffer[SECTORSIZE*SECSPERTRACK];
int trackReadSize,writeSize,trackNum;
bool convertError;
int direction;
long filepos,sideOffset;

bool validateParams(int argc,char *argv[])
{
   if (argc!=4) {
     fputs("usage: ./cpm86Converter.x input-image-file output-image-file vmw-to-cpmt|cpmt-to-vmw\n",stderr);
     return(false);
   }

   if (strcmp(argv[3],"vmw-to-cpmt")==0) {
     direction=VM_TO_TOOLS;
   }
   else if (strcmp(argv[3],"cpmt-to-vmw")==0) {
     direction=TOOLS_TO_VM;
   }
   else {
     fputs("usage: option is only vmw-to-cpmt or cpmt-to-vmw !\n",stderr);
     return(false);
   }
   return true;
}

bool validateFiles(int argc,char *argv[])
{
//    inFile=open(argv[1],O_RDONLY|O_BINARY,S_IREAD);
    inFile=open(argv[1],O_RDONLY,S_IREAD);
    if (inFile<0) {
      fputs("error: cpm86Converter could not open input-file\n",stderr);
      return(false);
    }
//    outFile=open(argv[2],O_CREAT|O_WRONLY|O_BINARY,S_IREAD|S_IWRITE);
    outFile=open(argv[2],O_CREAT|O_WRONLY,S_IREAD|S_IWRITE);
    if (outFile<0) {
      fputs("error: cpm86Converter could not write output file\n",stderr);
      return(false);
    }
    return true;
}

//bool validateFiles0(int argc,char *argv[])
//{
//    inFile=open(argv[1],O_RDONLY|O_BINARY,S_IREAD);
//    if (inFile<0) {
//      fputs("error: cpm86Converter could not open input-file\n",stderr);
//      return(false);
//    }
//    outFile=open(argv[2],O_CREAT|O_WRONLY|O_BINARY,S_IREAD|S_IWRITE);
//    if (outFile<0) {
//      fputs("error: cpm86Converter could not write output file\n",stderr);
//      return(false);
//    }
//}


void convertTrack(int headNum)
{
	filepos=lseek(outFile,sideOffset*headNum+(long)trackNum*SECTORSIZE*SECSPERTRACK,SEEK_SET);
//	printf("Read Track %d Head %d at %ld (%d bytes)...\n",trackNum,headNum,filepos,trackReadSize);
	writeSize=write(outFile,buffer,trackReadSize);
	if (writeSize!=SECSPERTRACK*SECTORSIZE) {
	  fprintf(stderr,"error: cpm86Converter could not write further tracks (Track #%d Head %d)\n",trackNum, headNum);
	  convertError=true; /* leaves while loop */
	}
	else{
		/* "trackNum" can be incremented after reading TWO tracks */
		trackNum+=headNum;
	}
}

void convertHead(int headNum)
{
//      if (headNum==0) filepos=lseek(inFile,(long)trackNum*(long)SECTORSIZE*(long)SECSPERTRACK,SEEK_SET);
//      if (headNum==1) filepos=lseek(inFile,sideOffset+(long)trackNum*(long)SECTORSIZE*(long)SECSPERTRACK,SEEK_SET);

	filepos=lseek(inFile,sideOffset*headNum+(long)trackNum*(long)SECTORSIZE*(long)SECSPERTRACK,SEEK_SET);
	trackReadSize=read(inFile,buffer,SECTORSIZE*SECSPERTRACK);

//	printf("Reading Track %d Head %d from pos %ld (%d bytes)...\n",trackNum, headNum, filepos, trackReadSize);

	if (trackReadSize>0) {
		writeSize=write(outFile,buffer,trackReadSize);
		if (writeSize!=trackReadSize) {
		  fputs("error: cpm86Converter could not write track to output file\n",stderr);
		  convertError=true;
		}
	}
}

bool convertVMToTools()
{
	int headNum=0;

	trackReadSize=read(inFile,buffer,SECSPERTRACK*SECTORSIZE);
	while ((trackReadSize==SECTORSIZE*SECSPERTRACK) &&(trackNum<TRACKSPERSIDE) && (!convertError)) {
		convertTrack(headNum);
		headNum=1-headNum;
		fflush(stdout);
		trackReadSize=read(inFile,buffer,SECSPERTRACK*SECTORSIZE);
	} /* while ends */
	return true;
}

void convertToolsToVM()
{
	/* Head 0 starts at filepos 0, Head 1 starts at filepos SECTORSIZExSECSPERTRACKxTRACKSPERSIDE */

	trackReadSize=SECTORSIZE*SECSPERTRACK;

	while ((trackNum<TRACKSPERSIDE)&&(trackReadSize>0)&&(!convertError)){
		convertHead(0);
		convertHead(1);
		trackNum++;
	}
}

int main(int argc,char *argv[])
{

	if (!validateParams(argc, argv)) return (1);
	if (!validateFiles(argc, argv)) return (1);

	sideOffset=(long)SECTORSIZE*(long)SECSPERTRACK*(long)TRACKSPERSIDE;
	trackNum=0;
	convertError=false;

	/* expecting now direction to be 1 or 0 for split or reassemble */
	puts("Opening input file...");
	if (direction==VM_TO_TOOLS) {
		convertVMToTools();
	} /* direction branch ends here */
	else { /* merge branch starts here */
		convertToolsToVM();
	} /* merge branchs ends here */
	close(inFile);
	close(outFile);
	if (convertError) return(1);
	puts("Output file written.");
	return(0);
}

