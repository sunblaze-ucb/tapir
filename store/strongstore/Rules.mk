d := $(dir $(lastword $(MAKEFILE_LIST)))

SRCS += $(addprefix $(d), occstore.cc lockstore.cc server.cc \
					client.cc shardclient.cc)

PROTOS += $(addprefix $(d), strong-proto.proto)

LIB-strong-store := $(o)occstore.o $(o)lockstore.o

OBJS-strong-store := $(LIB-message) $(LIB-strong-store) $(LIB-store-common) \
	$(LIB-store-backend) $(o)strong-proto.o $(o)server.o

OBJS-strong-client := $(o)strong-proto.o $(o)shardclient.o $(o)client.o

$(d)server: $(LIB-udptransport) $(OBJS-vr-replica) $(OBJS-strong-store)
$(d)client: $(LIB-udptransport) $(OBJS-vr-client) $(LIB-request) $(LIB-store-common) $(LIB-store-frontend) \
	$(LIB-latency) $(LIB-$(OBJS-strong-client)

BINS += $(d)server $(d)client
