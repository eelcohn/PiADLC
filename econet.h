/* econet.h
 * All Econet send and receive functions
 *
 * (c) Eelco Huininga 2018
 */

#ifndef ECONET_ECONET_HEADER
#define ECONET_ECONET_HEADER

#define ECONET_MAX_FRAMESIZE		32768		// Maximum size of an Econet frame is 32768 bytes (todo: need to check what the maximum allowed framesize is according to Acorn specifications)



namespace econet {
	typedef struct {
		unsigned char network;
		unsigned char station;
	} Station;

	typedef struct {
		unsigned char status;
		union {
			unsigned char data[ECONET_MAX_FRAMESIZE];
			struct {
				unsigned char dst_network;
				unsigned char dst_station;
				unsigned char src_network;
				unsigned char src_station;
			};
		};
		unsigned char control;
		unsigned char port;
	} Frame;

	void	pollNetworkReceive(void);
	void	transmitFrame(econet::Frame *frame, int size);
	bool	validateFrame(econet::Frame *frame, int size);
	void	processFrame(econet::Frame *frame, int size);
	void	sendBridgeAnnounce(void);
	void	sendWhatNetBroadcast(void);
	bool	startSession(unsigned char network, unsigned char station, unsigned char port);
	bool	hasSession(unsigned char network, unsigned char station, unsigned char port);
	bool	endSession(unsigned char network, unsigned char station, unsigned char port);
}

#endif
