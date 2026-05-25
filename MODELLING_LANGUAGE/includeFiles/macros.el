#define INIT_V3D(vect,i1,i2,i3,init) \
EXPAND( i IN 1,i1) \
    EXPAND( j IN 1,i2) \
        EXPAND( k IN 1,i3) \
            vect[i,j,k] = init
