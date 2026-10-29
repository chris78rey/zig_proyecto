const __root = @This();
pub const __builtin = @import("std").zig.c_translation.builtins;
pub const __helpers = @import("std").zig.c_translation.helpers;
pub const __u_char = u8;
pub const __u_short = c_ushort;
pub const __u_int = c_uint;
pub const __u_long = c_ulong;
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_long;
pub const __uint64_t = c_ulong;
pub const __int_least8_t = __int8_t;
pub const __uint_least8_t = __uint8_t;
pub const __int_least16_t = __int16_t;
pub const __uint_least16_t = __uint16_t;
pub const __int_least32_t = __int32_t;
pub const __uint_least32_t = __uint32_t;
pub const __int_least64_t = __int64_t;
pub const __uint_least64_t = __uint64_t;
pub const __quad_t = c_long;
pub const __u_quad_t = c_ulong;
pub const __intmax_t = c_long;
pub const __uintmax_t = c_ulong;
pub const __dev_t = c_ulong;
pub const __uid_t = c_uint;
pub const __gid_t = c_uint;
pub const __ino_t = c_ulong;
pub const __ino64_t = c_ulong;
pub const __mode_t = c_uint;
pub const __nlink_t = c_ulong;
pub const __off_t = c_long;
pub const __off64_t = c_long;
pub const __pid_t = c_int;
pub const __fsid_t = extern struct {
    __val: [2]c_int = @import("std").mem.zeroes([2]c_int),
};
pub const __clock_t = c_long;
pub const __rlim_t = c_ulong;
pub const __rlim64_t = c_ulong;
pub const __id_t = c_uint;
pub const __time_t = c_long;
pub const __useconds_t = c_uint;
pub const __suseconds_t = c_long;
pub const __suseconds64_t = c_long;
pub const __daddr_t = c_int;
pub const __key_t = c_int;
pub const __clockid_t = c_int;
pub const __timer_t = ?*anyopaque;
pub const __blksize_t = c_long;
pub const __blkcnt_t = c_long;
pub const __blkcnt64_t = c_long;
pub const __fsblkcnt_t = c_ulong;
pub const __fsblkcnt64_t = c_ulong;
pub const __fsfilcnt_t = c_ulong;
pub const __fsfilcnt64_t = c_ulong;
pub const __fsword_t = c_long;
pub const __ssize_t = c_long;
pub const __syscall_slong_t = c_long;
pub const __syscall_ulong_t = c_ulong;
pub const __loff_t = __off64_t;
pub const __caddr_t = [*c]u8;
pub const __intptr_t = c_long;
pub const __socklen_t = c_uint;
pub const __sig_atomic_t = c_int;
pub const int_least8_t = __int_least8_t;
pub const int_least16_t = __int_least16_t;
pub const int_least32_t = __int_least32_t;
pub const int_least64_t = __int_least64_t;
pub const uint_least8_t = __uint_least8_t;
pub const uint_least16_t = __uint_least16_t;
pub const uint_least32_t = __uint_least32_t;
pub const uint_least64_t = __uint_least64_t;
pub const int_fast8_t = i8;
pub const int_fast16_t = c_long;
pub const int_fast32_t = c_long;
pub const int_fast64_t = c_long;
pub const uint_fast8_t = u8;
pub const uint_fast16_t = c_ulong;
pub const uint_fast32_t = c_ulong;
pub const uint_fast64_t = c_ulong;
pub const intmax_t = __intmax_t;
pub const uintmax_t = __uintmax_t;
pub const dpiAuthMode = u32;
pub const dpiConnCloseMode = u32;
pub const dpiCreateMode = u32;
pub const dpiDeqMode = u32;
pub const dpiDeqNavigation = u32;
pub const dpiEventType = u32;
pub const dpiExecMode = u32;
pub const dpiFetchMode = u16;
pub const dpiMessageDeliveryMode = u16;
pub const dpiMessageState = u32;
pub const dpiNativeTypeNum = u32;
pub const dpiOpCode = u32;
pub const dpiOracleTypeNum = u32;
pub const dpiPoolCloseMode = u32;
pub const dpiPoolGetMode = u8;
pub const dpiPurity = u32;
pub const dpiShutdownMode = u32;
pub const dpiStartupMode = u32;
pub const dpiServerType = u8;
pub const dpiStatementType = u16;
pub const dpiSubscrGroupingClass = u8;
pub const dpiSubscrGroupingType = u8;
pub const dpiSubscrNamespace = u32;
pub const dpiSubscrProtocol = u32;
pub const dpiSubscrQOS = u32;
pub const dpiTpcBeginFlags = u32;
pub const dpiTpcEndFlags = u32;
pub const dpiVectorFlags = u8;
pub const dpiVectorFormat = u8;
pub const dpiVisibility = u32;
pub const struct_dpiConn = opaque {
    pub const dpiConn_addRef = __root.dpiConn_addRef;
    pub const dpiConn_breakExecution = __root.dpiConn_breakExecution;
    pub const dpiConn_changePassword = __root.dpiConn_changePassword;
    pub const dpiConn_clearAppContext = __root.dpiConn_clearAppContext;
    pub const dpiConn_close = __root.dpiConn_close;
    pub const dpiConn_commit = __root.dpiConn_commit;
    pub const dpiConn_deqObject = __root.dpiConn_deqObject;
    pub const dpiConn_enqObject = __root.dpiConn_enqObject;
    pub const dpiConn_getCallTimeout = __root.dpiConn_getCallTimeout;
    pub const dpiConn_getCurrentSchema = __root.dpiConn_getCurrentSchema;
    pub const dpiConn_getDbDomain = __root.dpiConn_getDbDomain;
    pub const dpiConn_getDbName = __root.dpiConn_getDbName;
    pub const dpiConn_getEdition = __root.dpiConn_getEdition;
    pub const dpiConn_getEncodingInfo = __root.dpiConn_getEncodingInfo;
    pub const dpiConn_getExternalName = __root.dpiConn_getExternalName;
    pub const dpiConn_getHandle = __root.dpiConn_getHandle;
    pub const dpiConn_getInfo = __root.dpiConn_getInfo;
    pub const dpiConn_getInstanceName = __root.dpiConn_getInstanceName;
    pub const dpiConn_getInternalName = __root.dpiConn_getInternalName;
    pub const dpiConn_getIsHealthy = __root.dpiConn_getIsHealthy;
    pub const dpiConn_getLTXID = __root.dpiConn_getLTXID;
    pub const dpiConn_getMaxOpenCursors = __root.dpiConn_getMaxOpenCursors;
    pub const dpiConn_getObjectType = __root.dpiConn_getObjectType;
    pub const dpiConn_getOciAttr = __root.dpiConn_getOciAttr;
    pub const dpiConn_getPdbName = __root.dpiConn_getPdbName;
    pub const dpiConn_getServerVersion = __root.dpiConn_getServerVersion;
    pub const dpiConn_getServiceName = __root.dpiConn_getServiceName;
    pub const dpiConn_getSodaDb = __root.dpiConn_getSodaDb;
    pub const dpiConn_getStmtCacheSize = __root.dpiConn_getStmtCacheSize;
    pub const dpiConn_getTransactionInProgress = __root.dpiConn_getTransactionInProgress;
    pub const dpiConn_getTransactionPriority = __root.dpiConn_getTransactionPriority;
    pub const dpiConn_newDeqOptions = __root.dpiConn_newDeqOptions;
    pub const dpiConn_newEnqOptions = __root.dpiConn_newEnqOptions;
    pub const dpiConn_newJson = __root.dpiConn_newJson;
    pub const dpiConn_newJsonQueue = __root.dpiConn_newJsonQueue;
    pub const dpiConn_newMsgProps = __root.dpiConn_newMsgProps;
    pub const dpiConn_newQueue = __root.dpiConn_newQueue;
    pub const dpiConn_newTempLob = __root.dpiConn_newTempLob;
    pub const dpiConn_newVar = __root.dpiConn_newVar;
    pub const dpiConn_newVector = __root.dpiConn_newVector;
    pub const dpiConn_ping = __root.dpiConn_ping;
    pub const dpiConn_prepareStmt = __root.dpiConn_prepareStmt;
    pub const dpiConn_release = __root.dpiConn_release;
    pub const dpiConn_rollback = __root.dpiConn_rollback;
    pub const dpiConn_setAction = __root.dpiConn_setAction;
    pub const dpiConn_setAppContext = __root.dpiConn_setAppContext;
    pub const dpiConn_setCallTimeout = __root.dpiConn_setCallTimeout;
    pub const dpiConn_setClientIdentifier = __root.dpiConn_setClientIdentifier;
    pub const dpiConn_setClientInfo = __root.dpiConn_setClientInfo;
    pub const dpiConn_setCurrentSchema = __root.dpiConn_setCurrentSchema;
    pub const dpiConn_setDbOp = __root.dpiConn_setDbOp;
    pub const dpiConn_setEcontextId = __root.dpiConn_setEcontextId;
    pub const dpiConn_setExternalName = __root.dpiConn_setExternalName;
    pub const dpiConn_setInternalName = __root.dpiConn_setInternalName;
    pub const dpiConn_setModule = __root.dpiConn_setModule;
    pub const dpiConn_setOciAttr = __root.dpiConn_setOciAttr;
    pub const dpiConn_setStmtCacheSize = __root.dpiConn_setStmtCacheSize;
    pub const dpiConn_setTransactionPriority = __root.dpiConn_setTransactionPriority;
    pub const dpiConn_shutdownDatabase = __root.dpiConn_shutdownDatabase;
    pub const dpiConn_startupDatabase = __root.dpiConn_startupDatabase;
    pub const dpiConn_startupDatabaseWithPfile = __root.dpiConn_startupDatabaseWithPfile;
    pub const dpiConn_stmtFromHandle = __root.dpiConn_stmtFromHandle;
    pub const dpiConn_subscribe = __root.dpiConn_subscribe;
    pub const dpiConn_tpcBegin = __root.dpiConn_tpcBegin;
    pub const dpiConn_tpcCommit = __root.dpiConn_tpcCommit;
    pub const dpiConn_tpcEnd = __root.dpiConn_tpcEnd;
    pub const dpiConn_tpcForget = __root.dpiConn_tpcForget;
    pub const dpiConn_tpcPrepare = __root.dpiConn_tpcPrepare;
    pub const dpiConn_tpcRollback = __root.dpiConn_tpcRollback;
    pub const dpiConn_unsubscribe = __root.dpiConn_unsubscribe;
    pub const dpiConn_beginSessionlessTransaction = __root.dpiConn_beginSessionlessTransaction;
    pub const dpiConn_resumeSessionlessTransaction = __root.dpiConn_resumeSessionlessTransaction;
    pub const dpiConn_suspendSessionlessTransaction = __root.dpiConn_suspendSessionlessTransaction;
    pub const addRef = __root.dpiConn_addRef;
    pub const breakExecution = __root.dpiConn_breakExecution;
    pub const changePassword = __root.dpiConn_changePassword;
    pub const clearAppContext = __root.dpiConn_clearAppContext;
    pub const close = __root.dpiConn_close;
    pub const commit = __root.dpiConn_commit;
    pub const deqObject = __root.dpiConn_deqObject;
    pub const enqObject = __root.dpiConn_enqObject;
    pub const getCallTimeout = __root.dpiConn_getCallTimeout;
    pub const getCurrentSchema = __root.dpiConn_getCurrentSchema;
    pub const getDbDomain = __root.dpiConn_getDbDomain;
    pub const getDbName = __root.dpiConn_getDbName;
    pub const getEdition = __root.dpiConn_getEdition;
    pub const getEncodingInfo = __root.dpiConn_getEncodingInfo;
    pub const getExternalName = __root.dpiConn_getExternalName;
    pub const getHandle = __root.dpiConn_getHandle;
    pub const getInfo = __root.dpiConn_getInfo;
    pub const getInstanceName = __root.dpiConn_getInstanceName;
    pub const getInternalName = __root.dpiConn_getInternalName;
    pub const getIsHealthy = __root.dpiConn_getIsHealthy;
    pub const getLTXID = __root.dpiConn_getLTXID;
    pub const getMaxOpenCursors = __root.dpiConn_getMaxOpenCursors;
    pub const getObjectType = __root.dpiConn_getObjectType;
    pub const getOciAttr = __root.dpiConn_getOciAttr;
    pub const getPdbName = __root.dpiConn_getPdbName;
    pub const getServerVersion = __root.dpiConn_getServerVersion;
    pub const getServiceName = __root.dpiConn_getServiceName;
    pub const getSodaDb = __root.dpiConn_getSodaDb;
    pub const getStmtCacheSize = __root.dpiConn_getStmtCacheSize;
    pub const getTransactionInProgress = __root.dpiConn_getTransactionInProgress;
    pub const getTransactionPriority = __root.dpiConn_getTransactionPriority;
    pub const newDeqOptions = __root.dpiConn_newDeqOptions;
    pub const newEnqOptions = __root.dpiConn_newEnqOptions;
    pub const newJson = __root.dpiConn_newJson;
    pub const newJsonQueue = __root.dpiConn_newJsonQueue;
    pub const newMsgProps = __root.dpiConn_newMsgProps;
    pub const newQueue = __root.dpiConn_newQueue;
    pub const newTempLob = __root.dpiConn_newTempLob;
    pub const newVar = __root.dpiConn_newVar;
    pub const newVector = __root.dpiConn_newVector;
    pub const ping = __root.dpiConn_ping;
    pub const prepareStmt = __root.dpiConn_prepareStmt;
    pub const release = __root.dpiConn_release;
    pub const rollback = __root.dpiConn_rollback;
    pub const setAction = __root.dpiConn_setAction;
    pub const setAppContext = __root.dpiConn_setAppContext;
    pub const setCallTimeout = __root.dpiConn_setCallTimeout;
    pub const setClientIdentifier = __root.dpiConn_setClientIdentifier;
    pub const setClientInfo = __root.dpiConn_setClientInfo;
    pub const setCurrentSchema = __root.dpiConn_setCurrentSchema;
    pub const setDbOp = __root.dpiConn_setDbOp;
    pub const setEcontextId = __root.dpiConn_setEcontextId;
    pub const setExternalName = __root.dpiConn_setExternalName;
    pub const setInternalName = __root.dpiConn_setInternalName;
    pub const setModule = __root.dpiConn_setModule;
    pub const setOciAttr = __root.dpiConn_setOciAttr;
    pub const setStmtCacheSize = __root.dpiConn_setStmtCacheSize;
    pub const setTransactionPriority = __root.dpiConn_setTransactionPriority;
    pub const shutdownDatabase = __root.dpiConn_shutdownDatabase;
    pub const startupDatabase = __root.dpiConn_startupDatabase;
    pub const startupDatabaseWithPfile = __root.dpiConn_startupDatabaseWithPfile;
    pub const stmtFromHandle = __root.dpiConn_stmtFromHandle;
    pub const subscribe = __root.dpiConn_subscribe;
    pub const tpcBegin = __root.dpiConn_tpcBegin;
    pub const tpcCommit = __root.dpiConn_tpcCommit;
    pub const tpcEnd = __root.dpiConn_tpcEnd;
    pub const tpcForget = __root.dpiConn_tpcForget;
    pub const tpcPrepare = __root.dpiConn_tpcPrepare;
    pub const tpcRollback = __root.dpiConn_tpcRollback;
    pub const unsubscribe = __root.dpiConn_unsubscribe;
    pub const beginSessionlessTransaction = __root.dpiConn_beginSessionlessTransaction;
    pub const resumeSessionlessTransaction = __root.dpiConn_resumeSessionlessTransaction;
    pub const suspendSessionlessTransaction = __root.dpiConn_suspendSessionlessTransaction;
};
pub const dpiConn = struct_dpiConn;
pub const struct_dpiContext = opaque {
    pub const dpiContext_destroy = __root.dpiContext_destroy;
    pub const dpiContext_freeStringList = __root.dpiContext_freeStringList;
    pub const dpiContext_getClientVersion = __root.dpiContext_getClientVersion;
    pub const dpiContext_getError = __root.dpiContext_getError;
    pub const dpiContext_initCommonCreateParams = __root.dpiContext_initCommonCreateParams;
    pub const dpiContext_initConnCreateParams = __root.dpiContext_initConnCreateParams;
    pub const dpiContext_initPoolCreateParams = __root.dpiContext_initPoolCreateParams;
    pub const dpiContext_initSodaOperOptions = __root.dpiContext_initSodaOperOptions;
    pub const dpiContext_initSubscrCreateParams = __root.dpiContext_initSubscrCreateParams;
    pub const dpiConn_create = __root.dpiConn_create;
    pub const dpiPool_create = __root.dpiPool_create;
    pub const destroy = __root.dpiContext_destroy;
    pub const freeStringList = __root.dpiContext_freeStringList;
    pub const getClientVersion = __root.dpiContext_getClientVersion;
    pub const getError = __root.dpiContext_getError;
    pub const initCommonCreateParams = __root.dpiContext_initCommonCreateParams;
    pub const initConnCreateParams = __root.dpiContext_initConnCreateParams;
    pub const initPoolCreateParams = __root.dpiContext_initPoolCreateParams;
    pub const initSodaOperOptions = __root.dpiContext_initSodaOperOptions;
    pub const initSubscrCreateParams = __root.dpiContext_initSubscrCreateParams;
    pub const create = __root.dpiConn_create;
};
pub const dpiContext = struct_dpiContext;
pub const struct_dpiDeqOptions = opaque {
    pub const dpiDeqOptions_addRef = __root.dpiDeqOptions_addRef;
    pub const dpiDeqOptions_getCondition = __root.dpiDeqOptions_getCondition;
    pub const dpiDeqOptions_getConsumerName = __root.dpiDeqOptions_getConsumerName;
    pub const dpiDeqOptions_getCorrelation = __root.dpiDeqOptions_getCorrelation;
    pub const dpiDeqOptions_getMode = __root.dpiDeqOptions_getMode;
    pub const dpiDeqOptions_getMsgId = __root.dpiDeqOptions_getMsgId;
    pub const dpiDeqOptions_getNavigation = __root.dpiDeqOptions_getNavigation;
    pub const dpiDeqOptions_getTransformation = __root.dpiDeqOptions_getTransformation;
    pub const dpiDeqOptions_getVisibility = __root.dpiDeqOptions_getVisibility;
    pub const dpiDeqOptions_getWait = __root.dpiDeqOptions_getWait;
    pub const dpiDeqOptions_release = __root.dpiDeqOptions_release;
    pub const dpiDeqOptions_setCondition = __root.dpiDeqOptions_setCondition;
    pub const dpiDeqOptions_setConsumerName = __root.dpiDeqOptions_setConsumerName;
    pub const dpiDeqOptions_setCorrelation = __root.dpiDeqOptions_setCorrelation;
    pub const dpiDeqOptions_setDeliveryMode = __root.dpiDeqOptions_setDeliveryMode;
    pub const dpiDeqOptions_setMode = __root.dpiDeqOptions_setMode;
    pub const dpiDeqOptions_setMsgId = __root.dpiDeqOptions_setMsgId;
    pub const dpiDeqOptions_setNavigation = __root.dpiDeqOptions_setNavigation;
    pub const dpiDeqOptions_setTransformation = __root.dpiDeqOptions_setTransformation;
    pub const dpiDeqOptions_setVisibility = __root.dpiDeqOptions_setVisibility;
    pub const dpiDeqOptions_setWait = __root.dpiDeqOptions_setWait;
    pub const addRef = __root.dpiDeqOptions_addRef;
    pub const getCondition = __root.dpiDeqOptions_getCondition;
    pub const getConsumerName = __root.dpiDeqOptions_getConsumerName;
    pub const getCorrelation = __root.dpiDeqOptions_getCorrelation;
    pub const getMode = __root.dpiDeqOptions_getMode;
    pub const getMsgId = __root.dpiDeqOptions_getMsgId;
    pub const getNavigation = __root.dpiDeqOptions_getNavigation;
    pub const getTransformation = __root.dpiDeqOptions_getTransformation;
    pub const getVisibility = __root.dpiDeqOptions_getVisibility;
    pub const getWait = __root.dpiDeqOptions_getWait;
    pub const release = __root.dpiDeqOptions_release;
    pub const setCondition = __root.dpiDeqOptions_setCondition;
    pub const setConsumerName = __root.dpiDeqOptions_setConsumerName;
    pub const setCorrelation = __root.dpiDeqOptions_setCorrelation;
    pub const setDeliveryMode = __root.dpiDeqOptions_setDeliveryMode;
    pub const setMode = __root.dpiDeqOptions_setMode;
    pub const setMsgId = __root.dpiDeqOptions_setMsgId;
    pub const setNavigation = __root.dpiDeqOptions_setNavigation;
    pub const setTransformation = __root.dpiDeqOptions_setTransformation;
    pub const setVisibility = __root.dpiDeqOptions_setVisibility;
    pub const setWait = __root.dpiDeqOptions_setWait;
};
pub const dpiDeqOptions = struct_dpiDeqOptions;
pub const struct_dpiEnqOptions = opaque {
    pub const dpiEnqOptions_addRef = __root.dpiEnqOptions_addRef;
    pub const dpiEnqOptions_getTransformation = __root.dpiEnqOptions_getTransformation;
    pub const dpiEnqOptions_getVisibility = __root.dpiEnqOptions_getVisibility;
    pub const dpiEnqOptions_release = __root.dpiEnqOptions_release;
    pub const dpiEnqOptions_setDeliveryMode = __root.dpiEnqOptions_setDeliveryMode;
    pub const dpiEnqOptions_setTransformation = __root.dpiEnqOptions_setTransformation;
    pub const dpiEnqOptions_setVisibility = __root.dpiEnqOptions_setVisibility;
    pub const addRef = __root.dpiEnqOptions_addRef;
    pub const getTransformation = __root.dpiEnqOptions_getTransformation;
    pub const getVisibility = __root.dpiEnqOptions_getVisibility;
    pub const release = __root.dpiEnqOptions_release;
    pub const setDeliveryMode = __root.dpiEnqOptions_setDeliveryMode;
    pub const setTransformation = __root.dpiEnqOptions_setTransformation;
    pub const setVisibility = __root.dpiEnqOptions_setVisibility;
};
pub const dpiEnqOptions = struct_dpiEnqOptions;
pub const struct_dpiJson = opaque {
    pub const dpiJson_addRef = __root.dpiJson_addRef;
    pub const dpiJson_getValue = __root.dpiJson_getValue;
    pub const dpiJson_release = __root.dpiJson_release;
    pub const dpiJson_setFromText = __root.dpiJson_setFromText;
    pub const dpiJson_setValue = __root.dpiJson_setValue;
    pub const addRef = __root.dpiJson_addRef;
    pub const getValue = __root.dpiJson_getValue;
    pub const release = __root.dpiJson_release;
    pub const setFromText = __root.dpiJson_setFromText;
    pub const setValue = __root.dpiJson_setValue;
};
pub const dpiJson = struct_dpiJson;
pub const struct_dpiLob = opaque {
    pub const dpiLob_addRef = __root.dpiLob_addRef;
    pub const dpiLob_close = __root.dpiLob_close;
    pub const dpiLob_closeResource = __root.dpiLob_closeResource;
    pub const dpiLob_copy = __root.dpiLob_copy;
    pub const dpiLob_getBufferSize = __root.dpiLob_getBufferSize;
    pub const dpiLob_getChunkSize = __root.dpiLob_getChunkSize;
    pub const dpiLob_getDirectoryAndFileName = __root.dpiLob_getDirectoryAndFileName;
    pub const dpiLob_getFileExists = __root.dpiLob_getFileExists;
    pub const dpiLob_getIsResourceOpen = __root.dpiLob_getIsResourceOpen;
    pub const dpiLob_getSize = __root.dpiLob_getSize;
    pub const dpiLob_getType = __root.dpiLob_getType;
    pub const dpiLob_openResource = __root.dpiLob_openResource;
    pub const dpiLob_readBytes = __root.dpiLob_readBytes;
    pub const dpiLob_release = __root.dpiLob_release;
    pub const dpiLob_setDirectoryAndFileName = __root.dpiLob_setDirectoryAndFileName;
    pub const dpiLob_setFromBytes = __root.dpiLob_setFromBytes;
    pub const dpiLob_trim = __root.dpiLob_trim;
    pub const dpiLob_writeBytes = __root.dpiLob_writeBytes;
    pub const addRef = __root.dpiLob_addRef;
    pub const close = __root.dpiLob_close;
    pub const closeResource = __root.dpiLob_closeResource;
    pub const copy = __root.dpiLob_copy;
    pub const getBufferSize = __root.dpiLob_getBufferSize;
    pub const getChunkSize = __root.dpiLob_getChunkSize;
    pub const getDirectoryAndFileName = __root.dpiLob_getDirectoryAndFileName;
    pub const getFileExists = __root.dpiLob_getFileExists;
    pub const getIsResourceOpen = __root.dpiLob_getIsResourceOpen;
    pub const getSize = __root.dpiLob_getSize;
    pub const getType = __root.dpiLob_getType;
    pub const openResource = __root.dpiLob_openResource;
    pub const readBytes = __root.dpiLob_readBytes;
    pub const release = __root.dpiLob_release;
    pub const setDirectoryAndFileName = __root.dpiLob_setDirectoryAndFileName;
    pub const setFromBytes = __root.dpiLob_setFromBytes;
    pub const trim = __root.dpiLob_trim;
    pub const writeBytes = __root.dpiLob_writeBytes;
};
pub const dpiLob = struct_dpiLob;
pub const struct_dpiMsgProps = opaque {
    pub const dpiMsgProps_addRef = __root.dpiMsgProps_addRef;
    pub const dpiMsgProps_getNumAttempts = __root.dpiMsgProps_getNumAttempts;
    pub const dpiMsgProps_getCorrelation = __root.dpiMsgProps_getCorrelation;
    pub const dpiMsgProps_getDelay = __root.dpiMsgProps_getDelay;
    pub const dpiMsgProps_getDeliveryMode = __root.dpiMsgProps_getDeliveryMode;
    pub const dpiMsgProps_getEnqTime = __root.dpiMsgProps_getEnqTime;
    pub const dpiMsgProps_getExceptionQ = __root.dpiMsgProps_getExceptionQ;
    pub const dpiMsgProps_getExpiration = __root.dpiMsgProps_getExpiration;
    pub const dpiMsgProps_getMsgId = __root.dpiMsgProps_getMsgId;
    pub const dpiMsgProps_getOriginalMsgId = __root.dpiMsgProps_getOriginalMsgId;
    pub const dpiMsgProps_getPayload = __root.dpiMsgProps_getPayload;
    pub const dpiMsgProps_getPayloadJson = __root.dpiMsgProps_getPayloadJson;
    pub const dpiMsgProps_getPriority = __root.dpiMsgProps_getPriority;
    pub const dpiMsgProps_getState = __root.dpiMsgProps_getState;
    pub const dpiMsgProps_release = __root.dpiMsgProps_release;
    pub const dpiMsgProps_setCorrelation = __root.dpiMsgProps_setCorrelation;
    pub const dpiMsgProps_setDelay = __root.dpiMsgProps_setDelay;
    pub const dpiMsgProps_setExceptionQ = __root.dpiMsgProps_setExceptionQ;
    pub const dpiMsgProps_setExpiration = __root.dpiMsgProps_setExpiration;
    pub const dpiMsgProps_setOriginalMsgId = __root.dpiMsgProps_setOriginalMsgId;
    pub const dpiMsgProps_setPayloadBytes = __root.dpiMsgProps_setPayloadBytes;
    pub const dpiMsgProps_setPayloadJson = __root.dpiMsgProps_setPayloadJson;
    pub const dpiMsgProps_setPayloadObject = __root.dpiMsgProps_setPayloadObject;
    pub const dpiMsgProps_setPriority = __root.dpiMsgProps_setPriority;
    pub const dpiMsgProps_setRecipients = __root.dpiMsgProps_setRecipients;
    pub const addRef = __root.dpiMsgProps_addRef;
    pub const getNumAttempts = __root.dpiMsgProps_getNumAttempts;
    pub const getCorrelation = __root.dpiMsgProps_getCorrelation;
    pub const getDelay = __root.dpiMsgProps_getDelay;
    pub const getDeliveryMode = __root.dpiMsgProps_getDeliveryMode;
    pub const getEnqTime = __root.dpiMsgProps_getEnqTime;
    pub const getExceptionQ = __root.dpiMsgProps_getExceptionQ;
    pub const getExpiration = __root.dpiMsgProps_getExpiration;
    pub const getMsgId = __root.dpiMsgProps_getMsgId;
    pub const getOriginalMsgId = __root.dpiMsgProps_getOriginalMsgId;
    pub const getPayload = __root.dpiMsgProps_getPayload;
    pub const getPayloadJson = __root.dpiMsgProps_getPayloadJson;
    pub const getPriority = __root.dpiMsgProps_getPriority;
    pub const getState = __root.dpiMsgProps_getState;
    pub const release = __root.dpiMsgProps_release;
    pub const setCorrelation = __root.dpiMsgProps_setCorrelation;
    pub const setDelay = __root.dpiMsgProps_setDelay;
    pub const setExceptionQ = __root.dpiMsgProps_setExceptionQ;
    pub const setExpiration = __root.dpiMsgProps_setExpiration;
    pub const setOriginalMsgId = __root.dpiMsgProps_setOriginalMsgId;
    pub const setPayloadBytes = __root.dpiMsgProps_setPayloadBytes;
    pub const setPayloadJson = __root.dpiMsgProps_setPayloadJson;
    pub const setPayloadObject = __root.dpiMsgProps_setPayloadObject;
    pub const setPriority = __root.dpiMsgProps_setPriority;
    pub const setRecipients = __root.dpiMsgProps_setRecipients;
};
pub const dpiMsgProps = struct_dpiMsgProps;
pub const struct_dpiObject = opaque {
    pub const dpiObject_addRef = __root.dpiObject_addRef;
    pub const dpiObject_appendElement = __root.dpiObject_appendElement;
    pub const dpiObject_copy = __root.dpiObject_copy;
    pub const dpiObject_deleteElementByIndex = __root.dpiObject_deleteElementByIndex;
    pub const dpiObject_getAttributeValue = __root.dpiObject_getAttributeValue;
    pub const dpiObject_getElementExistsByIndex = __root.dpiObject_getElementExistsByIndex;
    pub const dpiObject_getElementValueByIndex = __root.dpiObject_getElementValueByIndex;
    pub const dpiObject_getFirstIndex = __root.dpiObject_getFirstIndex;
    pub const dpiObject_getLastIndex = __root.dpiObject_getLastIndex;
    pub const dpiObject_getNextIndex = __root.dpiObject_getNextIndex;
    pub const dpiObject_getPrevIndex = __root.dpiObject_getPrevIndex;
    pub const dpiObject_getSize = __root.dpiObject_getSize;
    pub const dpiObject_release = __root.dpiObject_release;
    pub const dpiObject_setAttributeValue = __root.dpiObject_setAttributeValue;
    pub const dpiObject_setElementValueByIndex = __root.dpiObject_setElementValueByIndex;
    pub const dpiObject_trim = __root.dpiObject_trim;
    pub const addRef = __root.dpiObject_addRef;
    pub const appendElement = __root.dpiObject_appendElement;
    pub const copy = __root.dpiObject_copy;
    pub const deleteElementByIndex = __root.dpiObject_deleteElementByIndex;
    pub const getAttributeValue = __root.dpiObject_getAttributeValue;
    pub const getElementExistsByIndex = __root.dpiObject_getElementExistsByIndex;
    pub const getElementValueByIndex = __root.dpiObject_getElementValueByIndex;
    pub const getFirstIndex = __root.dpiObject_getFirstIndex;
    pub const getLastIndex = __root.dpiObject_getLastIndex;
    pub const getNextIndex = __root.dpiObject_getNextIndex;
    pub const getPrevIndex = __root.dpiObject_getPrevIndex;
    pub const getSize = __root.dpiObject_getSize;
    pub const release = __root.dpiObject_release;
    pub const setAttributeValue = __root.dpiObject_setAttributeValue;
    pub const setElementValueByIndex = __root.dpiObject_setElementValueByIndex;
    pub const trim = __root.dpiObject_trim;
};
pub const dpiObject = struct_dpiObject;
pub const struct_dpiObjectAttr = opaque {
    pub const dpiObjectAttr_addRef = __root.dpiObjectAttr_addRef;
    pub const dpiObjectAttr_getInfo = __root.dpiObjectAttr_getInfo;
    pub const dpiObjectAttr_release = __root.dpiObjectAttr_release;
    pub const addRef = __root.dpiObjectAttr_addRef;
    pub const getInfo = __root.dpiObjectAttr_getInfo;
    pub const release = __root.dpiObjectAttr_release;
};
pub const dpiObjectAttr = struct_dpiObjectAttr;
pub const struct_dpiObjectType = opaque {
    pub const dpiObjectType_addRef = __root.dpiObjectType_addRef;
    pub const dpiObjectType_createObject = __root.dpiObjectType_createObject;
    pub const dpiObjectType_getAttributes = __root.dpiObjectType_getAttributes;
    pub const dpiObjectType_getInfo = __root.dpiObjectType_getInfo;
    pub const dpiObjectType_release = __root.dpiObjectType_release;
    pub const addRef = __root.dpiObjectType_addRef;
    pub const createObject = __root.dpiObjectType_createObject;
    pub const getAttributes = __root.dpiObjectType_getAttributes;
    pub const getInfo = __root.dpiObjectType_getInfo;
    pub const release = __root.dpiObjectType_release;
};
pub const dpiObjectType = struct_dpiObjectType;
pub const struct_dpiPool = opaque {
    pub const dpiPool_acquireConnection = __root.dpiPool_acquireConnection;
    pub const dpiPool_addRef = __root.dpiPool_addRef;
    pub const dpiPool_close = __root.dpiPool_close;
    pub const dpiPool_getBusyCount = __root.dpiPool_getBusyCount;
    pub const dpiPool_getEncodingInfo = __root.dpiPool_getEncodingInfo;
    pub const dpiPool_getGetMode = __root.dpiPool_getGetMode;
    pub const dpiPool_getMaxLifetimeSession = __root.dpiPool_getMaxLifetimeSession;
    pub const dpiPool_getMaxSessionsPerShard = __root.dpiPool_getMaxSessionsPerShard;
    pub const dpiPool_getOpenCount = __root.dpiPool_getOpenCount;
    pub const dpiPool_getSodaMetadataCache = __root.dpiPool_getSodaMetadataCache;
    pub const dpiPool_getStmtCacheSize = __root.dpiPool_getStmtCacheSize;
    pub const dpiPool_getTimeout = __root.dpiPool_getTimeout;
    pub const dpiPool_getWaitTimeout = __root.dpiPool_getWaitTimeout;
    pub const dpiPool_getPingInterval = __root.dpiPool_getPingInterval;
    pub const dpiPool_release = __root.dpiPool_release;
    pub const dpiPool_setAccessToken = __root.dpiPool_setAccessToken;
    pub const dpiPool_setGetMode = __root.dpiPool_setGetMode;
    pub const dpiPool_setMaxLifetimeSession = __root.dpiPool_setMaxLifetimeSession;
    pub const dpiPool_setMaxSessionsPerShard = __root.dpiPool_setMaxSessionsPerShard;
    pub const dpiPool_setSodaMetadataCache = __root.dpiPool_setSodaMetadataCache;
    pub const dpiPool_setStmtCacheSize = __root.dpiPool_setStmtCacheSize;
    pub const dpiPool_setTimeout = __root.dpiPool_setTimeout;
    pub const dpiPool_setWaitTimeout = __root.dpiPool_setWaitTimeout;
    pub const dpiPool_setPingInterval = __root.dpiPool_setPingInterval;
    pub const dpiPool_reconfigure = __root.dpiPool_reconfigure;
    pub const acquireConnection = __root.dpiPool_acquireConnection;
    pub const addRef = __root.dpiPool_addRef;
    pub const close = __root.dpiPool_close;
    pub const getBusyCount = __root.dpiPool_getBusyCount;
    pub const getEncodingInfo = __root.dpiPool_getEncodingInfo;
    pub const getGetMode = __root.dpiPool_getGetMode;
    pub const getMaxLifetimeSession = __root.dpiPool_getMaxLifetimeSession;
    pub const getMaxSessionsPerShard = __root.dpiPool_getMaxSessionsPerShard;
    pub const getOpenCount = __root.dpiPool_getOpenCount;
    pub const getSodaMetadataCache = __root.dpiPool_getSodaMetadataCache;
    pub const getStmtCacheSize = __root.dpiPool_getStmtCacheSize;
    pub const getTimeout = __root.dpiPool_getTimeout;
    pub const getWaitTimeout = __root.dpiPool_getWaitTimeout;
    pub const getPingInterval = __root.dpiPool_getPingInterval;
    pub const release = __root.dpiPool_release;
    pub const setAccessToken = __root.dpiPool_setAccessToken;
    pub const setGetMode = __root.dpiPool_setGetMode;
    pub const setMaxLifetimeSession = __root.dpiPool_setMaxLifetimeSession;
    pub const setMaxSessionsPerShard = __root.dpiPool_setMaxSessionsPerShard;
    pub const setSodaMetadataCache = __root.dpiPool_setSodaMetadataCache;
    pub const setStmtCacheSize = __root.dpiPool_setStmtCacheSize;
    pub const setTimeout = __root.dpiPool_setTimeout;
    pub const setWaitTimeout = __root.dpiPool_setWaitTimeout;
    pub const setPingInterval = __root.dpiPool_setPingInterval;
    pub const reconfigure = __root.dpiPool_reconfigure;
};
pub const dpiPool = struct_dpiPool;
pub const struct_dpiQueue = opaque {
    pub const dpiQueue_addRef = __root.dpiQueue_addRef;
    pub const dpiQueue_deqMany = __root.dpiQueue_deqMany;
    pub const dpiQueue_deqOne = __root.dpiQueue_deqOne;
    pub const dpiQueue_enqMany = __root.dpiQueue_enqMany;
    pub const dpiQueue_enqOne = __root.dpiQueue_enqOne;
    pub const dpiQueue_getDeqOptions = __root.dpiQueue_getDeqOptions;
    pub const dpiQueue_getEnqOptions = __root.dpiQueue_getEnqOptions;
    pub const dpiQueue_release = __root.dpiQueue_release;
    pub const addRef = __root.dpiQueue_addRef;
    pub const deqMany = __root.dpiQueue_deqMany;
    pub const deqOne = __root.dpiQueue_deqOne;
    pub const enqMany = __root.dpiQueue_enqMany;
    pub const enqOne = __root.dpiQueue_enqOne;
    pub const getDeqOptions = __root.dpiQueue_getDeqOptions;
    pub const getEnqOptions = __root.dpiQueue_getEnqOptions;
    pub const release = __root.dpiQueue_release;
};
pub const dpiQueue = struct_dpiQueue;
pub const struct_dpiRowid = opaque {
    pub const dpiRowid_addRef = __root.dpiRowid_addRef;
    pub const dpiRowid_getStringValue = __root.dpiRowid_getStringValue;
    pub const dpiRowid_release = __root.dpiRowid_release;
    pub const addRef = __root.dpiRowid_addRef;
    pub const getStringValue = __root.dpiRowid_getStringValue;
    pub const release = __root.dpiRowid_release;
};
pub const dpiRowid = struct_dpiRowid;
pub const struct_dpiSodaColl = opaque {
    pub const dpiSodaColl_addRef = __root.dpiSodaColl_addRef;
    pub const dpiSodaColl_createIndex = __root.dpiSodaColl_createIndex;
    pub const dpiSodaColl_drop = __root.dpiSodaColl_drop;
    pub const dpiSodaColl_dropIndex = __root.dpiSodaColl_dropIndex;
    pub const dpiSodaColl_find = __root.dpiSodaColl_find;
    pub const dpiSodaColl_findOne = __root.dpiSodaColl_findOne;
    pub const dpiSodaColl_getDataGuide = __root.dpiSodaColl_getDataGuide;
    pub const dpiSodaColl_getDocCount = __root.dpiSodaColl_getDocCount;
    pub const dpiSodaColl_getMetadata = __root.dpiSodaColl_getMetadata;
    pub const dpiSodaColl_getName = __root.dpiSodaColl_getName;
    pub const dpiSodaColl_insertMany = __root.dpiSodaColl_insertMany;
    pub const dpiSodaColl_insertManyWithOptions = __root.dpiSodaColl_insertManyWithOptions;
    pub const dpiSodaColl_insertOne = __root.dpiSodaColl_insertOne;
    pub const dpiSodaColl_insertOneWithOptions = __root.dpiSodaColl_insertOneWithOptions;
    pub const dpiSodaColl_listIndexes = __root.dpiSodaColl_listIndexes;
    pub const dpiSodaColl_release = __root.dpiSodaColl_release;
    pub const dpiSodaColl_remove = __root.dpiSodaColl_remove;
    pub const dpiSodaColl_replaceOne = __root.dpiSodaColl_replaceOne;
    pub const dpiSodaColl_save = __root.dpiSodaColl_save;
    pub const dpiSodaColl_saveWithOptions = __root.dpiSodaColl_saveWithOptions;
    pub const dpiSodaColl_truncate = __root.dpiSodaColl_truncate;
    pub const addRef = __root.dpiSodaColl_addRef;
    pub const createIndex = __root.dpiSodaColl_createIndex;
    pub const drop = __root.dpiSodaColl_drop;
    pub const dropIndex = __root.dpiSodaColl_dropIndex;
    pub const find = __root.dpiSodaColl_find;
    pub const findOne = __root.dpiSodaColl_findOne;
    pub const getDataGuide = __root.dpiSodaColl_getDataGuide;
    pub const getDocCount = __root.dpiSodaColl_getDocCount;
    pub const getMetadata = __root.dpiSodaColl_getMetadata;
    pub const getName = __root.dpiSodaColl_getName;
    pub const insertMany = __root.dpiSodaColl_insertMany;
    pub const insertManyWithOptions = __root.dpiSodaColl_insertManyWithOptions;
    pub const insertOne = __root.dpiSodaColl_insertOne;
    pub const insertOneWithOptions = __root.dpiSodaColl_insertOneWithOptions;
    pub const listIndexes = __root.dpiSodaColl_listIndexes;
    pub const release = __root.dpiSodaColl_release;
    pub const remove = __root.dpiSodaColl_remove;
    pub const replaceOne = __root.dpiSodaColl_replaceOne;
    pub const save = __root.dpiSodaColl_save;
    pub const saveWithOptions = __root.dpiSodaColl_saveWithOptions;
    pub const truncate = __root.dpiSodaColl_truncate;
};
pub const dpiSodaColl = struct_dpiSodaColl;
pub const struct_dpiSodaCollCursor = opaque {
    pub const dpiSodaCollCursor_addRef = __root.dpiSodaCollCursor_addRef;
    pub const dpiSodaCollCursor_close = __root.dpiSodaCollCursor_close;
    pub const dpiSodaCollCursor_getNext = __root.dpiSodaCollCursor_getNext;
    pub const dpiSodaCollCursor_release = __root.dpiSodaCollCursor_release;
    pub const addRef = __root.dpiSodaCollCursor_addRef;
    pub const close = __root.dpiSodaCollCursor_close;
    pub const getNext = __root.dpiSodaCollCursor_getNext;
    pub const release = __root.dpiSodaCollCursor_release;
};
pub const dpiSodaCollCursor = struct_dpiSodaCollCursor;
pub const struct_dpiSodaDb = opaque {
    pub const dpiSodaDb_addRef = __root.dpiSodaDb_addRef;
    pub const dpiSodaDb_createCollection = __root.dpiSodaDb_createCollection;
    pub const dpiSodaDb_createDocument = __root.dpiSodaDb_createDocument;
    pub const dpiSodaDb_createJsonDocument = __root.dpiSodaDb_createJsonDocument;
    pub const dpiSodaDb_getCollections = __root.dpiSodaDb_getCollections;
    pub const dpiSodaDb_getCollectionNames = __root.dpiSodaDb_getCollectionNames;
    pub const dpiSodaDb_openCollection = __root.dpiSodaDb_openCollection;
    pub const dpiSodaDb_release = __root.dpiSodaDb_release;
    pub const addRef = __root.dpiSodaDb_addRef;
    pub const createCollection = __root.dpiSodaDb_createCollection;
    pub const createDocument = __root.dpiSodaDb_createDocument;
    pub const createJsonDocument = __root.dpiSodaDb_createJsonDocument;
    pub const getCollections = __root.dpiSodaDb_getCollections;
    pub const getCollectionNames = __root.dpiSodaDb_getCollectionNames;
    pub const openCollection = __root.dpiSodaDb_openCollection;
    pub const release = __root.dpiSodaDb_release;
};
pub const dpiSodaDb = struct_dpiSodaDb;
pub const struct_dpiSodaDoc = opaque {
    pub const dpiSodaDoc_addRef = __root.dpiSodaDoc_addRef;
    pub const dpiSodaDoc_getContent = __root.dpiSodaDoc_getContent;
    pub const dpiSodaDoc_getCreatedOn = __root.dpiSodaDoc_getCreatedOn;
    pub const dpiSodaDoc_getIsJson = __root.dpiSodaDoc_getIsJson;
    pub const dpiSodaDoc_getJsonContent = __root.dpiSodaDoc_getJsonContent;
    pub const dpiSodaDoc_getKey = __root.dpiSodaDoc_getKey;
    pub const dpiSodaDoc_getLastModified = __root.dpiSodaDoc_getLastModified;
    pub const dpiSodaDoc_getMediaType = __root.dpiSodaDoc_getMediaType;
    pub const dpiSodaDoc_getVersion = __root.dpiSodaDoc_getVersion;
    pub const dpiSodaDoc_release = __root.dpiSodaDoc_release;
    pub const addRef = __root.dpiSodaDoc_addRef;
    pub const getContent = __root.dpiSodaDoc_getContent;
    pub const getCreatedOn = __root.dpiSodaDoc_getCreatedOn;
    pub const getIsJson = __root.dpiSodaDoc_getIsJson;
    pub const getJsonContent = __root.dpiSodaDoc_getJsonContent;
    pub const getKey = __root.dpiSodaDoc_getKey;
    pub const getLastModified = __root.dpiSodaDoc_getLastModified;
    pub const getMediaType = __root.dpiSodaDoc_getMediaType;
    pub const getVersion = __root.dpiSodaDoc_getVersion;
    pub const release = __root.dpiSodaDoc_release;
};
pub const dpiSodaDoc = struct_dpiSodaDoc;
pub const struct_dpiSodaDocCursor = opaque {
    pub const dpiSodaDocCursor_addRef = __root.dpiSodaDocCursor_addRef;
    pub const dpiSodaDocCursor_close = __root.dpiSodaDocCursor_close;
    pub const dpiSodaDocCursor_getNext = __root.dpiSodaDocCursor_getNext;
    pub const dpiSodaDocCursor_release = __root.dpiSodaDocCursor_release;
    pub const addRef = __root.dpiSodaDocCursor_addRef;
    pub const close = __root.dpiSodaDocCursor_close;
    pub const getNext = __root.dpiSodaDocCursor_getNext;
    pub const release = __root.dpiSodaDocCursor_release;
};
pub const dpiSodaDocCursor = struct_dpiSodaDocCursor;
pub const struct_dpiStmt = opaque {
    pub const dpiStmt_addRef = __root.dpiStmt_addRef;
    pub const dpiStmt_bindByName = __root.dpiStmt_bindByName;
    pub const dpiStmt_bindByPos = __root.dpiStmt_bindByPos;
    pub const dpiStmt_bindValueByName = __root.dpiStmt_bindValueByName;
    pub const dpiStmt_bindValueByPos = __root.dpiStmt_bindValueByPos;
    pub const dpiStmt_close = __root.dpiStmt_close;
    pub const dpiStmt_define = __root.dpiStmt_define;
    pub const dpiStmt_defineValue = __root.dpiStmt_defineValue;
    pub const dpiStmt_execute = __root.dpiStmt_execute;
    pub const dpiStmt_executeMany = __root.dpiStmt_executeMany;
    pub const dpiStmt_fetch = __root.dpiStmt_fetch;
    pub const dpiStmt_fetchRows = __root.dpiStmt_fetchRows;
    pub const dpiStmt_getBatchErrorCount = __root.dpiStmt_getBatchErrorCount;
    pub const dpiStmt_getBatchErrors = __root.dpiStmt_getBatchErrors;
    pub const dpiStmt_getBindCount = __root.dpiStmt_getBindCount;
    pub const dpiStmt_getBindNames = __root.dpiStmt_getBindNames;
    pub const dpiStmt_getFetchArraySize = __root.dpiStmt_getFetchArraySize;
    pub const dpiStmt_getHandle = __root.dpiStmt_getHandle;
    pub const dpiStmt_getImplicitResult = __root.dpiStmt_getImplicitResult;
    pub const dpiStmt_getInfo = __root.dpiStmt_getInfo;
    pub const dpiStmt_getLastRowid = __root.dpiStmt_getLastRowid;
    pub const dpiStmt_getNumQueryColumns = __root.dpiStmt_getNumQueryColumns;
    pub const dpiStmt_getOciAttr = __root.dpiStmt_getOciAttr;
    pub const dpiStmt_getPrefetchRows = __root.dpiStmt_getPrefetchRows;
    pub const dpiStmt_getQueryInfo = __root.dpiStmt_getQueryInfo;
    pub const dpiStmt_getQueryValue = __root.dpiStmt_getQueryValue;
    pub const dpiStmt_getRowCount = __root.dpiStmt_getRowCount;
    pub const dpiStmt_getRowCounts = __root.dpiStmt_getRowCounts;
    pub const dpiStmt_getSubscrQueryId = __root.dpiStmt_getSubscrQueryId;
    pub const dpiStmt_release = __root.dpiStmt_release;
    pub const dpiStmt_scroll = __root.dpiStmt_scroll;
    pub const dpiStmt_setFetchArraySize = __root.dpiStmt_setFetchArraySize;
    pub const dpiStmt_setOciAttr = __root.dpiStmt_setOciAttr;
    pub const dpiStmt_setPrefetchRows = __root.dpiStmt_setPrefetchRows;
    pub const dpiStmt_deleteFromCache = __root.dpiStmt_deleteFromCache;
    pub const addRef = __root.dpiStmt_addRef;
    pub const bindByName = __root.dpiStmt_bindByName;
    pub const bindByPos = __root.dpiStmt_bindByPos;
    pub const bindValueByName = __root.dpiStmt_bindValueByName;
    pub const bindValueByPos = __root.dpiStmt_bindValueByPos;
    pub const close = __root.dpiStmt_close;
    pub const define = __root.dpiStmt_define;
    pub const defineValue = __root.dpiStmt_defineValue;
    pub const execute = __root.dpiStmt_execute;
    pub const executeMany = __root.dpiStmt_executeMany;
    pub const fetch = __root.dpiStmt_fetch;
    pub const fetchRows = __root.dpiStmt_fetchRows;
    pub const getBatchErrorCount = __root.dpiStmt_getBatchErrorCount;
    pub const getBatchErrors = __root.dpiStmt_getBatchErrors;
    pub const getBindCount = __root.dpiStmt_getBindCount;
    pub const getBindNames = __root.dpiStmt_getBindNames;
    pub const getFetchArraySize = __root.dpiStmt_getFetchArraySize;
    pub const getHandle = __root.dpiStmt_getHandle;
    pub const getImplicitResult = __root.dpiStmt_getImplicitResult;
    pub const getInfo = __root.dpiStmt_getInfo;
    pub const getLastRowid = __root.dpiStmt_getLastRowid;
    pub const getNumQueryColumns = __root.dpiStmt_getNumQueryColumns;
    pub const getOciAttr = __root.dpiStmt_getOciAttr;
    pub const getPrefetchRows = __root.dpiStmt_getPrefetchRows;
    pub const getQueryInfo = __root.dpiStmt_getQueryInfo;
    pub const getQueryValue = __root.dpiStmt_getQueryValue;
    pub const getRowCount = __root.dpiStmt_getRowCount;
    pub const getRowCounts = __root.dpiStmt_getRowCounts;
    pub const getSubscrQueryId = __root.dpiStmt_getSubscrQueryId;
    pub const release = __root.dpiStmt_release;
    pub const scroll = __root.dpiStmt_scroll;
    pub const setFetchArraySize = __root.dpiStmt_setFetchArraySize;
    pub const setOciAttr = __root.dpiStmt_setOciAttr;
    pub const setPrefetchRows = __root.dpiStmt_setPrefetchRows;
    pub const deleteFromCache = __root.dpiStmt_deleteFromCache;
};
pub const dpiStmt = struct_dpiStmt;
pub const struct_dpiSubscr = opaque {
    pub const dpiSubscr_addRef = __root.dpiSubscr_addRef;
    pub const dpiSubscr_prepareStmt = __root.dpiSubscr_prepareStmt;
    pub const dpiSubscr_release = __root.dpiSubscr_release;
    pub const addRef = __root.dpiSubscr_addRef;
    pub const prepareStmt = __root.dpiSubscr_prepareStmt;
    pub const release = __root.dpiSubscr_release;
};
pub const dpiSubscr = struct_dpiSubscr;
pub const struct_dpiVar = opaque {
    pub const dpiVar_addRef = __root.dpiVar_addRef;
    pub const dpiVar_copyData = __root.dpiVar_copyData;
    pub const dpiVar_getNumElementsInArray = __root.dpiVar_getNumElementsInArray;
    pub const dpiVar_getReturnedData = __root.dpiVar_getReturnedData;
    pub const dpiVar_getSizeInBytes = __root.dpiVar_getSizeInBytes;
    pub const dpiVar_release = __root.dpiVar_release;
    pub const dpiVar_setFromBytes = __root.dpiVar_setFromBytes;
    pub const dpiVar_setFromJson = __root.dpiVar_setFromJson;
    pub const dpiVar_setFromLob = __root.dpiVar_setFromLob;
    pub const dpiVar_setFromObject = __root.dpiVar_setFromObject;
    pub const dpiVar_setFromRowid = __root.dpiVar_setFromRowid;
    pub const dpiVar_setFromStmt = __root.dpiVar_setFromStmt;
    pub const dpiVar_setFromVector = __root.dpiVar_setFromVector;
    pub const dpiVar_setNumElementsInArray = __root.dpiVar_setNumElementsInArray;
    pub const addRef = __root.dpiVar_addRef;
    pub const copyData = __root.dpiVar_copyData;
    pub const getNumElementsInArray = __root.dpiVar_getNumElementsInArray;
    pub const getReturnedData = __root.dpiVar_getReturnedData;
    pub const getSizeInBytes = __root.dpiVar_getSizeInBytes;
    pub const release = __root.dpiVar_release;
    pub const setFromBytes = __root.dpiVar_setFromBytes;
    pub const setFromJson = __root.dpiVar_setFromJson;
    pub const setFromLob = __root.dpiVar_setFromLob;
    pub const setFromObject = __root.dpiVar_setFromObject;
    pub const setFromRowid = __root.dpiVar_setFromRowid;
    pub const setFromStmt = __root.dpiVar_setFromStmt;
    pub const setFromVector = __root.dpiVar_setFromVector;
    pub const setNumElementsInArray = __root.dpiVar_setNumElementsInArray;
};
pub const dpiVar = struct_dpiVar;
pub const struct_dpiVector = opaque {
    pub const dpiVector_addRef = __root.dpiVector_addRef;
    pub const dpiVector_getValue = __root.dpiVector_getValue;
    pub const dpiVector_release = __root.dpiVector_release;
    pub const dpiVector_setValue = __root.dpiVector_setValue;
    pub const addRef = __root.dpiVector_addRef;
    pub const getValue = __root.dpiVector_getValue;
    pub const release = __root.dpiVector_release;
    pub const setValue = __root.dpiVector_setValue;
};
pub const dpiVector = struct_dpiVector;
pub const struct_dpiAccessToken = extern struct {
    token: [*c]const u8 = null,
    tokenLength: u32 = 0,
    privateKey: [*c]const u8 = null,
    privateKeyLength: u32 = 0,
};
pub const dpiAccessToken = struct_dpiAccessToken;
pub const struct_dpiAnnotation = extern struct {
    key: [*c]const u8 = null,
    keyLength: u32 = 0,
    value: [*c]const u8 = null,
    valueLength: u32 = 0,
};
pub const dpiAnnotation = struct_dpiAnnotation;
pub const struct_dpiAppContext = extern struct {
    namespaceName: [*c]const u8 = null,
    namespaceNameLength: u32 = 0,
    name: [*c]const u8 = null,
    nameLength: u32 = 0,
    value: [*c]const u8 = null,
    valueLength: u32 = 0,
};
pub const dpiAppContext = struct_dpiAppContext;
pub const struct_dpiCommonCreateParams = extern struct {
    createMode: dpiCreateMode = 0,
    encoding: [*c]const u8 = null,
    nencoding: [*c]const u8 = null,
    edition: [*c]const u8 = null,
    editionLength: u32 = 0,
    driverName: [*c]const u8 = null,
    driverNameLength: u32 = 0,
    sodaMetadataCache: c_int = 0,
    stmtCacheSize: u32 = 0,
    accessToken: [*c]dpiAccessToken = null,
    transactionPriority: [*c]const u8 = null,
    transactionPriorityLength: u32 = 0,
};
pub const dpiCommonCreateParams = struct_dpiCommonCreateParams;
pub const union_dpiDataBuffer = extern union {
    asBoolean: c_int,
    asUint8: u8,
    asUint16: u16,
    asUint32: u32,
    asInt64: i64,
    asUint64: u64,
    asFloat: f32,
    asDouble: f64,
    asString: [*c]u8,
    asRaw: ?*anyopaque,
    asBytes: dpiBytes,
    asTimestamp: dpiTimestamp,
    asIntervalDS: dpiIntervalDS,
    asIntervalYM: dpiIntervalYM,
    asJson: ?*dpiJson,
    asJsonObject: dpiJsonObject,
    asJsonArray: dpiJsonArray,
    asLOB: ?*dpiLob,
    asObject: ?*dpiObject,
    asStmt: ?*dpiStmt,
    asRowid: ?*dpiRowid,
    asVector: ?*dpiVector,
};
pub const dpiDataBuffer = union_dpiDataBuffer;
pub const struct_dpiShardingKeyColumn = extern struct {
    oracleTypeNum: dpiOracleTypeNum = 0,
    nativeTypeNum: dpiNativeTypeNum = 0,
    value: dpiDataBuffer = @import("std").mem.zeroes(dpiDataBuffer),
};
pub const dpiShardingKeyColumn = struct_dpiShardingKeyColumn;
pub const struct_dpiConnCreateParams = extern struct {
    authMode: dpiAuthMode = 0,
    connectionClass: [*c]const u8 = null,
    connectionClassLength: u32 = 0,
    purity: dpiPurity = 0,
    newPassword: [*c]const u8 = null,
    newPasswordLength: u32 = 0,
    appContext: [*c]dpiAppContext = null,
    numAppContext: u32 = 0,
    externalAuth: c_int = 0,
    externalHandle: ?*anyopaque = null,
    pool: ?*dpiPool = null,
    tag: [*c]const u8 = null,
    tagLength: u32 = 0,
    matchAnyTag: c_int = 0,
    outTag: [*c]const u8 = null,
    outTagLength: u32 = 0,
    outTagFound: c_int = 0,
    shardingKeyColumns: [*c]dpiShardingKeyColumn = null,
    numShardingKeyColumns: u8 = 0,
    superShardingKeyColumns: [*c]dpiShardingKeyColumn = null,
    numSuperShardingKeyColumns: u8 = 0,
    outNewSession: c_int = 0,
};
pub const dpiConnCreateParams = struct_dpiConnCreateParams;
pub const struct_dpiConnInfo = extern struct {
    dbDomain: [*c]const u8 = null,
    dbDomainLength: u32 = 0,
    dbName: [*c]const u8 = null,
    dbNameLength: u32 = 0,
    instanceName: [*c]const u8 = null,
    instanceNameLength: u32 = 0,
    serviceName: [*c]const u8 = null,
    serviceNameLength: u32 = 0,
    maxIdentifierLength: u32 = 0,
    maxOpenCursors: u32 = 0,
    serverType: u8 = 0,
};
pub const dpiConnInfo = struct_dpiConnInfo;
pub const struct_dpiContextCreateParams = extern struct {
    defaultDriverName: [*c]const u8 = null,
    defaultEncoding: [*c]const u8 = null,
    loadErrorUrl: [*c]const u8 = null,
    oracleClientLibDir: [*c]const u8 = null,
    oracleClientConfigDir: [*c]const u8 = null,
    sodaUseJsonDesc: c_int = 0,
    useJsonId: c_int = 0,
};
pub const dpiContextCreateParams = struct_dpiContextCreateParams;
pub const struct_dpiData = extern struct {
    isNull: c_int = 0,
    value: dpiDataBuffer = @import("std").mem.zeroes(dpiDataBuffer),
    pub const dpiData_getBool = __root.dpiData_getBool;
    pub const dpiData_getBytes = __root.dpiData_getBytes;
    pub const dpiData_getDouble = __root.dpiData_getDouble;
    pub const dpiData_getFloat = __root.dpiData_getFloat;
    pub const dpiData_getInt64 = __root.dpiData_getInt64;
    pub const dpiData_getIntervalDS = __root.dpiData_getIntervalDS;
    pub const dpiData_getIntervalYM = __root.dpiData_getIntervalYM;
    pub const dpiData_getIsNull = __root.dpiData_getIsNull;
    pub const dpiData_getJson = __root.dpiData_getJson;
    pub const dpiData_getJsonArray = __root.dpiData_getJsonArray;
    pub const dpiData_getJsonObject = __root.dpiData_getJsonObject;
    pub const dpiData_getLOB = __root.dpiData_getLOB;
    pub const dpiData_getObject = __root.dpiData_getObject;
    pub const dpiData_getStmt = __root.dpiData_getStmt;
    pub const dpiData_getTimestamp = __root.dpiData_getTimestamp;
    pub const dpiData_getUint64 = __root.dpiData_getUint64;
    pub const dpiData_getVector = __root.dpiData_getVector;
    pub const dpiData_setBool = __root.dpiData_setBool;
    pub const dpiData_setBytes = __root.dpiData_setBytes;
    pub const dpiData_setDouble = __root.dpiData_setDouble;
    pub const dpiData_setFloat = __root.dpiData_setFloat;
    pub const dpiData_setInt64 = __root.dpiData_setInt64;
    pub const dpiData_setIntervalDS = __root.dpiData_setIntervalDS;
    pub const dpiData_setIntervalYM = __root.dpiData_setIntervalYM;
    pub const dpiData_setLOB = __root.dpiData_setLOB;
    pub const dpiData_setNull = __root.dpiData_setNull;
    pub const dpiData_setObject = __root.dpiData_setObject;
    pub const dpiData_setStmt = __root.dpiData_setStmt;
    pub const dpiData_setTimestamp = __root.dpiData_setTimestamp;
    pub const dpiData_setUint64 = __root.dpiData_setUint64;
    pub const getBool = __root.dpiData_getBool;
    pub const getBytes = __root.dpiData_getBytes;
    pub const getDouble = __root.dpiData_getDouble;
    pub const getFloat = __root.dpiData_getFloat;
    pub const getInt64 = __root.dpiData_getInt64;
    pub const getIntervalDS = __root.dpiData_getIntervalDS;
    pub const getIntervalYM = __root.dpiData_getIntervalYM;
    pub const getIsNull = __root.dpiData_getIsNull;
    pub const getJson = __root.dpiData_getJson;
    pub const getJsonArray = __root.dpiData_getJsonArray;
    pub const getJsonObject = __root.dpiData_getJsonObject;
    pub const getLOB = __root.dpiData_getLOB;
    pub const getObject = __root.dpiData_getObject;
    pub const getStmt = __root.dpiData_getStmt;
    pub const getTimestamp = __root.dpiData_getTimestamp;
    pub const getUint64 = __root.dpiData_getUint64;
    pub const getVector = __root.dpiData_getVector;
    pub const setBool = __root.dpiData_setBool;
    pub const setBytes = __root.dpiData_setBytes;
    pub const setDouble = __root.dpiData_setDouble;
    pub const setFloat = __root.dpiData_setFloat;
    pub const setInt64 = __root.dpiData_setInt64;
    pub const setIntervalDS = __root.dpiData_setIntervalDS;
    pub const setIntervalYM = __root.dpiData_setIntervalYM;
    pub const setLOB = __root.dpiData_setLOB;
    pub const setNull = __root.dpiData_setNull;
    pub const setObject = __root.dpiData_setObject;
    pub const setStmt = __root.dpiData_setStmt;
    pub const setTimestamp = __root.dpiData_setTimestamp;
    pub const setUint64 = __root.dpiData_setUint64;
};
pub const dpiData = struct_dpiData;
pub const struct_dpiDataTypeInfo = extern struct {
    oracleTypeNum: dpiOracleTypeNum = 0,
    defaultNativeTypeNum: dpiNativeTypeNum = 0,
    ociTypeCode: u16 = 0,
    dbSizeInBytes: u32 = 0,
    clientSizeInBytes: u32 = 0,
    sizeInChars: u32 = 0,
    precision: i16 = 0,
    scale: i8 = 0,
    fsPrecision: u8 = 0,
    objectType: ?*dpiObjectType = null,
    isJson: c_int = 0,
    domainSchema: [*c]const u8 = null,
    domainSchemaLength: u32 = 0,
    domainName: [*c]const u8 = null,
    domainNameLength: u32 = 0,
    numAnnotations: u32 = 0,
    annotations: [*c]dpiAnnotation = null,
    isOson: c_int = 0,
    vectorDimensions: u32 = 0,
    vectorFormat: u8 = 0,
    vectorFlags: u8 = 0,
};
pub const dpiDataTypeInfo = struct_dpiDataTypeInfo;
pub const struct_dpiEncodingInfo = extern struct {
    encoding: [*c]const u8 = null,
    maxBytesPerCharacter: i32 = 0,
    nencoding: [*c]const u8 = null,
    nmaxBytesPerCharacter: i32 = 0,
};
pub const dpiEncodingInfo = struct_dpiEncodingInfo;
pub const struct_dpiErrorInfo = extern struct {
    code: i32 = 0,
    offset16: u16 = 0,
    message: [*c]const u8 = null,
    messageLength: u32 = 0,
    encoding: [*c]const u8 = null,
    fnName: [*c]const u8 = null,
    action: [*c]const u8 = null,
    sqlState: [*c]const u8 = null,
    isRecoverable: c_int = 0,
    isWarning: c_int = 0,
    offset: u32 = 0,
};
pub const dpiErrorInfo = struct_dpiErrorInfo;
pub const struct_dpiJsonNode = extern struct {
    oracleTypeNum: dpiOracleTypeNum = 0,
    nativeTypeNum: dpiNativeTypeNum = 0,
    value: [*c]dpiDataBuffer = null,
};
pub const dpiJsonNode = struct_dpiJsonNode;
pub const struct_dpiMsgRecipient = extern struct {
    name: [*c]const u8 = null,
    nameLength: u32 = 0,
};
pub const dpiMsgRecipient = struct_dpiMsgRecipient;
pub const struct_dpiObjectAttrInfo = extern struct {
    name: [*c]const u8 = null,
    nameLength: u32 = 0,
    typeInfo: dpiDataTypeInfo = @import("std").mem.zeroes(dpiDataTypeInfo),
};
pub const dpiObjectAttrInfo = struct_dpiObjectAttrInfo;
pub const struct_dpiObjectTypeInfo = extern struct {
    schema: [*c]const u8 = null,
    schemaLength: u32 = 0,
    name: [*c]const u8 = null,
    nameLength: u32 = 0,
    isCollection: c_int = 0,
    elementTypeInfo: dpiDataTypeInfo = @import("std").mem.zeroes(dpiDataTypeInfo),
    numAttributes: u16 = 0,
    packageName: [*c]const u8 = null,
    packageNameLength: u32 = 0,
};
pub const dpiObjectTypeInfo = struct_dpiObjectTypeInfo;
pub const dpiAccessTokenCallback = ?*const fn (context: ?*anyopaque, accessToken: [*c]dpiAccessToken) callconv(.c) c_int;
pub const struct_dpiPoolCreateParams = extern struct {
    minSessions: u32 = 0,
    maxSessions: u32 = 0,
    sessionIncrement: u32 = 0,
    pingInterval: c_int = 0,
    pingTimeout: c_int = 0,
    homogeneous: c_int = 0,
    externalAuth: c_int = 0,
    getMode: dpiPoolGetMode = 0,
    outPoolName: [*c]const u8 = null,
    outPoolNameLength: u32 = 0,
    timeout: u32 = 0,
    waitTimeout: u32 = 0,
    maxLifetimeSession: u32 = 0,
    plsqlFixupCallback: [*c]const u8 = null,
    plsqlFixupCallbackLength: u32 = 0,
    maxSessionsPerShard: u32 = 0,
    accessTokenCallback: dpiAccessTokenCallback = null,
    accessTokenCallbackContext: ?*anyopaque = null,
};
pub const dpiPoolCreateParams = struct_dpiPoolCreateParams;
pub const struct_dpiQueryInfo = extern struct {
    name: [*c]const u8 = null,
    nameLength: u32 = 0,
    typeInfo: dpiDataTypeInfo = @import("std").mem.zeroes(dpiDataTypeInfo),
    nullOk: c_int = 0,
};
pub const dpiQueryInfo = struct_dpiQueryInfo;
pub const struct_dpiSessionlessTransactionId = extern struct {
    value: [64]u8 = @import("std").mem.zeroes([64]u8),
    length: u32 = 0,
};
pub const dpiSessionlessTransactionId = struct_dpiSessionlessTransactionId;
pub const struct_dpiSodaOperOptions = extern struct {
    numKeys: u32 = 0,
    keys: [*c][*c]const u8 = null,
    keyLengths: [*c]u32 = null,
    key: [*c]const u8 = null,
    keyLength: u32 = 0,
    version: [*c]const u8 = null,
    versionLength: u32 = 0,
    filter: [*c]const u8 = null,
    filterLength: u32 = 0,
    skip: u32 = 0,
    limit: u32 = 0,
    fetchArraySize: u32 = 0,
    hint: [*c]const u8 = null,
    hintLength: u32 = 0,
    lock: c_int = 0,
};
pub const dpiSodaOperOptions = struct_dpiSodaOperOptions;
pub const struct_dpiStmtInfo = extern struct {
    isQuery: c_int = 0,
    isPLSQL: c_int = 0,
    isDDL: c_int = 0,
    isDML: c_int = 0,
    statementType: dpiStatementType = 0,
    isReturning: c_int = 0,
    sqlId: [*c]u8 = null,
    sqlIdLength: u32 = 0,
};
pub const dpiStmtInfo = struct_dpiStmtInfo;
pub const struct_dpiStringList = extern struct {
    numStrings: u32 = 0,
    strings: [*c][*c]const u8 = null,
    stringLengths: [*c]u32 = null,
};
pub const dpiStringList = struct_dpiStringList;
pub const struct_dpiSubscrMessageRow = extern struct {
    operation: dpiOpCode = 0,
    rowid: [*c]const u8 = null,
    rowidLength: u32 = 0,
};
pub const dpiSubscrMessageRow = struct_dpiSubscrMessageRow;
pub const struct_dpiSubscrMessageTable = extern struct {
    operation: dpiOpCode = 0,
    name: [*c]const u8 = null,
    nameLength: u32 = 0,
    rows: [*c]dpiSubscrMessageRow = null,
    numRows: u32 = 0,
};
pub const dpiSubscrMessageTable = struct_dpiSubscrMessageTable;
pub const struct_dpiSubscrMessageQuery = extern struct {
    id: u64 = 0,
    operation: dpiOpCode = 0,
    tables: [*c]dpiSubscrMessageTable = null,
    numTables: u32 = 0,
};
pub const dpiSubscrMessageQuery = struct_dpiSubscrMessageQuery;
pub const struct_dpiSubscrMessage = extern struct {
    eventType: dpiEventType = 0,
    dbName: [*c]const u8 = null,
    dbNameLength: u32 = 0,
    tables: [*c]dpiSubscrMessageTable = null,
    numTables: u32 = 0,
    queries: [*c]dpiSubscrMessageQuery = null,
    numQueries: u32 = 0,
    errorInfo: [*c]dpiErrorInfo = null,
    txId: ?*const anyopaque = null,
    txIdLength: u32 = 0,
    registered: c_int = 0,
    queueName: [*c]const u8 = null,
    queueNameLength: u32 = 0,
    consumerName: [*c]const u8 = null,
    consumerNameLength: u32 = 0,
    aqMsgId: ?*const anyopaque = null,
    aqMsgIdLength: u32 = 0,
};
pub const dpiSubscrMessage = struct_dpiSubscrMessage;
pub const dpiSubscrCallback = ?*const fn (context: ?*anyopaque, message: [*c]dpiSubscrMessage) callconv(.c) void;
pub const struct_dpiSubscrCreateParams = extern struct {
    subscrNamespace: dpiSubscrNamespace = 0,
    protocol: dpiSubscrProtocol = 0,
    qos: dpiSubscrQOS = 0,
    operations: dpiOpCode = 0,
    portNumber: u32 = 0,
    timeout: u32 = 0,
    name: [*c]const u8 = null,
    nameLength: u32 = 0,
    callback: dpiSubscrCallback = null,
    callbackContext: ?*anyopaque = null,
    recipientName: [*c]const u8 = null,
    recipientNameLength: u32 = 0,
    ipAddress: [*c]const u8 = null,
    ipAddressLength: u32 = 0,
    groupingClass: u8 = 0,
    groupingValue: u32 = 0,
    groupingType: u8 = 0,
    outRegId: u64 = 0,
    clientInitiated: c_int = 0,
};
pub const dpiSubscrCreateParams = struct_dpiSubscrCreateParams;
pub const union_dpiVectorDimensionBuffer = extern union {
    asPtr: ?*anyopaque,
    asInt8: [*c]i8,
    asFloat: [*c]f32,
    asDouble: [*c]f64,
};
pub const dpiVectorDimensionBuffer = union_dpiVectorDimensionBuffer;
pub const struct_dpiVectorInfo = extern struct {
    format: u8 = 0,
    numDimensions: u32 = 0,
    dimensionSize: u8 = 0,
    dimensions: dpiVectorDimensionBuffer = @import("std").mem.zeroes(dpiVectorDimensionBuffer),
    isSparse: c_int = 0,
    numSparseValues: u32 = 0,
    sparseIndices: [*c]u32 = null,
};
pub const dpiVectorInfo = struct_dpiVectorInfo;
pub const struct_dpiVersionInfo = extern struct {
    versionNum: c_int = 0,
    releaseNum: c_int = 0,
    updateNum: c_int = 0,
    portReleaseNum: c_int = 0,
    portUpdateNum: c_int = 0,
    fullVersionNum: u32 = 0,
};
pub const dpiVersionInfo = struct_dpiVersionInfo;
pub const struct_dpiXid = extern struct {
    formatId: c_long = 0,
    globalTransactionId: [*c]const u8 = null,
    globalTransactionIdLength: u32 = 0,
    branchQualifier: [*c]const u8 = null,
    branchQualifierLength: u32 = 0,
};
pub const dpiXid = struct_dpiXid;
pub const dpiBytes = extern struct {
    ptr: [*c]u8 = null,
    length: u32 = 0,
    encoding: [*c]const u8 = null,
};
pub const dpiIntervalDS = extern struct {
    days: i32 = 0,
    hours: i32 = 0,
    minutes: i32 = 0,
    seconds: i32 = 0,
    fseconds: i32 = 0,
};
pub const dpiIntervalYM = extern struct {
    years: i32 = 0,
    months: i32 = 0,
};
pub const dpiJsonObject = extern struct {
    numFields: u32 = 0,
    fieldNames: [*c][*c]u8 = null,
    fieldNameLengths: [*c]u32 = null,
    fields: [*c]dpiJsonNode = null,
    fieldValues: [*c]dpiDataBuffer = null,
};
pub const dpiJsonArray = extern struct {
    numElements: u32 = 0,
    elements: [*c]dpiJsonNode = null,
    elementValues: [*c]dpiDataBuffer = null,
};
pub const dpiTimestamp = extern struct {
    year: i16 = 0,
    month: u8 = 0,
    day: u8 = 0,
    hour: u8 = 0,
    minute: u8 = 0,
    second: u8 = 0,
    fsecond: u32 = 0,
    tzHourOffset: i8 = 0,
    tzMinuteOffset: i8 = 0,
};
pub extern fn dpiContext_createWithParams(majorVersion: c_uint, minorVersion: c_uint, params: [*c]dpiContextCreateParams, context: [*c]?*dpiContext, errorInfo: [*c]dpiErrorInfo) c_int;
pub extern fn dpiContext_destroy(context: ?*dpiContext) c_int;
pub extern fn dpiContext_freeStringList(context: ?*dpiContext, list: [*c]dpiStringList) c_int;
pub extern fn dpiContext_getClientVersion(context: ?*const dpiContext, versionInfo: [*c]dpiVersionInfo) c_int;
pub extern fn dpiContext_getError(context: ?*const dpiContext, errorInfo: [*c]dpiErrorInfo) void;
pub extern fn dpiContext_initCommonCreateParams(context: ?*const dpiContext, params: [*c]dpiCommonCreateParams) c_int;
pub extern fn dpiContext_initConnCreateParams(context: ?*const dpiContext, params: [*c]dpiConnCreateParams) c_int;
pub extern fn dpiContext_initPoolCreateParams(context: ?*const dpiContext, params: [*c]dpiPoolCreateParams) c_int;
pub extern fn dpiContext_initSodaOperOptions(context: ?*const dpiContext, options: [*c]dpiSodaOperOptions) c_int;
pub extern fn dpiContext_initSubscrCreateParams(context: ?*const dpiContext, params: [*c]dpiSubscrCreateParams) c_int;
pub extern fn dpiConn_addRef(conn: ?*dpiConn) c_int;
pub extern fn dpiConn_breakExecution(conn: ?*dpiConn) c_int;
pub extern fn dpiConn_changePassword(conn: ?*dpiConn, userName: [*c]const u8, userNameLength: u32, oldPassword: [*c]const u8, oldPasswordLength: u32, newPassword: [*c]const u8, newPasswordLength: u32) c_int;
pub extern fn dpiConn_clearAppContext(conn: ?*dpiConn, namespaceName: [*c]const u8, namespaceNameLength: u32) c_int;
pub extern fn dpiConn_close(conn: ?*dpiConn, mode: dpiConnCloseMode, tag: [*c]const u8, tagLength: u32) c_int;
pub extern fn dpiConn_commit(conn: ?*dpiConn) c_int;
pub extern fn dpiConn_create(context: ?*const dpiContext, userName: [*c]const u8, userNameLength: u32, password: [*c]const u8, passwordLength: u32, connectString: [*c]const u8, connectStringLength: u32, commonParams: [*c]const dpiCommonCreateParams, createParams: [*c]dpiConnCreateParams, conn: [*c]?*dpiConn) c_int;
pub extern fn dpiConn_deqObject(conn: ?*dpiConn, queueName: [*c]const u8, queueNameLength: u32, options: ?*dpiDeqOptions, props: ?*dpiMsgProps, payload: ?*dpiObject, msgId: [*c][*c]const u8, msgIdLength: [*c]u32) c_int;
pub extern fn dpiConn_enqObject(conn: ?*dpiConn, queueName: [*c]const u8, queueNameLength: u32, options: ?*dpiEnqOptions, props: ?*dpiMsgProps, payload: ?*dpiObject, msgId: [*c][*c]const u8, msgIdLength: [*c]u32) c_int;
pub extern fn dpiConn_getCallTimeout(conn: ?*dpiConn, value: [*c]u32) c_int;
pub extern fn dpiConn_getCurrentSchema(conn: ?*dpiConn, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiConn_getDbDomain(conn: ?*dpiConn, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiConn_getDbName(conn: ?*dpiConn, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiConn_getEdition(conn: ?*dpiConn, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiConn_getEncodingInfo(conn: ?*dpiConn, info: [*c]dpiEncodingInfo) c_int;
pub extern fn dpiConn_getExternalName(conn: ?*dpiConn, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiConn_getHandle(conn: ?*dpiConn, handle: [*c]?*anyopaque) c_int;
pub extern fn dpiConn_getInfo(conn: ?*dpiConn, info: [*c]dpiConnInfo) c_int;
pub extern fn dpiConn_getInstanceName(conn: ?*dpiConn, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiConn_getInternalName(conn: ?*dpiConn, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiConn_getIsHealthy(conn: ?*dpiConn, isHealthy: [*c]c_int) c_int;
pub extern fn dpiConn_getLTXID(conn: ?*dpiConn, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiConn_getMaxOpenCursors(conn: ?*dpiConn, maxOpenCursors: [*c]u32) c_int;
pub extern fn dpiConn_getObjectType(conn: ?*dpiConn, name: [*c]const u8, nameLength: u32, objType: [*c]?*dpiObjectType) c_int;
pub extern fn dpiConn_getOciAttr(conn: ?*dpiConn, handleType: u32, attribute: u32, value: [*c]dpiDataBuffer, valueLength: [*c]u32) c_int;
pub extern fn dpiConn_getPdbName(conn: ?*dpiConn, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiConn_getServerVersion(conn: ?*dpiConn, releaseString: [*c][*c]const u8, releaseStringLength: [*c]u32, versionInfo: [*c]dpiVersionInfo) c_int;
pub extern fn dpiConn_getServiceName(conn: ?*dpiConn, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiConn_getSodaDb(conn: ?*dpiConn, db: [*c]?*dpiSodaDb) c_int;
pub extern fn dpiConn_getStmtCacheSize(conn: ?*dpiConn, cacheSize: [*c]u32) c_int;
pub extern fn dpiConn_getTransactionInProgress(conn: ?*dpiConn, txnInProgress: [*c]c_int) c_int;
pub extern fn dpiConn_getTransactionPriority(conn: ?*dpiConn, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiConn_newDeqOptions(conn: ?*dpiConn, options: [*c]?*dpiDeqOptions) c_int;
pub extern fn dpiConn_newEnqOptions(conn: ?*dpiConn, options: [*c]?*dpiEnqOptions) c_int;
pub extern fn dpiConn_newJson(conn: ?*dpiConn, json: [*c]?*dpiJson) c_int;
pub extern fn dpiConn_newJsonQueue(conn: ?*dpiConn, name: [*c]const u8, nameLength: u32, queue: [*c]?*dpiQueue) c_int;
pub extern fn dpiConn_newMsgProps(conn: ?*dpiConn, props: [*c]?*dpiMsgProps) c_int;
pub extern fn dpiConn_newQueue(conn: ?*dpiConn, name: [*c]const u8, nameLength: u32, payloadType: ?*dpiObjectType, queue: [*c]?*dpiQueue) c_int;
pub extern fn dpiConn_newTempLob(conn: ?*dpiConn, lobType: dpiOracleTypeNum, lob: [*c]?*dpiLob) c_int;
pub extern fn dpiConn_newVar(conn: ?*dpiConn, oracleTypeNum: dpiOracleTypeNum, nativeTypeNum: dpiNativeTypeNum, maxArraySize: u32, size: u32, sizeIsBytes: c_int, isArray: c_int, objType: ?*dpiObjectType, @"var": [*c]?*dpiVar, data: [*c][*c]dpiData) c_int;
pub extern fn dpiConn_newVector(conn: ?*dpiConn, info: [*c]dpiVectorInfo, vector: [*c]?*dpiVector) c_int;
pub extern fn dpiConn_ping(conn: ?*dpiConn) c_int;
pub extern fn dpiConn_prepareStmt(conn: ?*dpiConn, scrollable: c_int, sql: [*c]const u8, sqlLength: u32, tag: [*c]const u8, tagLength: u32, stmt: [*c]?*dpiStmt) c_int;
pub extern fn dpiConn_release(conn: ?*dpiConn) c_int;
pub extern fn dpiConn_rollback(conn: ?*dpiConn) c_int;
pub extern fn dpiConn_setAction(conn: ?*dpiConn, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiConn_setAppContext(conn: ?*dpiConn, numAppContext: u32, appContext: [*c]dpiAppContext) c_int;
pub extern fn dpiConn_setCallTimeout(conn: ?*dpiConn, value: u32) c_int;
pub extern fn dpiConn_setClientIdentifier(conn: ?*dpiConn, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiConn_setClientInfo(conn: ?*dpiConn, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiConn_setCurrentSchema(conn: ?*dpiConn, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiConn_setDbOp(conn: ?*dpiConn, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiConn_setEcontextId(conn: ?*dpiConn, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiConn_setExternalName(conn: ?*dpiConn, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiConn_setInternalName(conn: ?*dpiConn, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiConn_setModule(conn: ?*dpiConn, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiConn_setOciAttr(conn: ?*dpiConn, handleType: u32, attribute: u32, value: ?*anyopaque, valueLength: u32) c_int;
pub extern fn dpiConn_setStmtCacheSize(conn: ?*dpiConn, cacheSize: u32) c_int;
pub extern fn dpiConn_setTransactionPriority(conn: ?*dpiConn, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiConn_shutdownDatabase(conn: ?*dpiConn, mode: dpiShutdownMode) c_int;
pub extern fn dpiConn_startupDatabase(conn: ?*dpiConn, mode: dpiStartupMode) c_int;
pub extern fn dpiConn_startupDatabaseWithPfile(conn: ?*dpiConn, pfile: [*c]const u8, pfileLength: u32, mode: dpiStartupMode) c_int;
pub extern fn dpiConn_stmtFromHandle(conn: ?*dpiConn, externalHandle: ?*anyopaque, stmt: [*c]?*dpiStmt) c_int;
pub extern fn dpiConn_subscribe(conn: ?*dpiConn, params: [*c]dpiSubscrCreateParams, subscr: [*c]?*dpiSubscr) c_int;
pub extern fn dpiConn_tpcBegin(conn: ?*dpiConn, xid: [*c]dpiXid, transactionTimeout: u32, flags: u32) c_int;
pub extern fn dpiConn_tpcCommit(conn: ?*dpiConn, xid: [*c]dpiXid, onePhase: c_int) c_int;
pub extern fn dpiConn_tpcEnd(conn: ?*dpiConn, xid: [*c]dpiXid, flags: u32) c_int;
pub extern fn dpiConn_tpcForget(conn: ?*dpiConn, xid: [*c]dpiXid) c_int;
pub extern fn dpiConn_tpcPrepare(conn: ?*dpiConn, xid: [*c]dpiXid, commitNeeded: [*c]c_int) c_int;
pub extern fn dpiConn_tpcRollback(conn: ?*dpiConn, xid: [*c]dpiXid) c_int;
pub extern fn dpiConn_unsubscribe(conn: ?*dpiConn, subscr: ?*dpiSubscr) c_int;
pub extern fn dpiConn_beginSessionlessTransaction(conn: ?*dpiConn, transactionId: [*c]dpiSessionlessTransactionId, timeout: u32, deferRoundTrip: c_int) c_int;
pub extern fn dpiConn_resumeSessionlessTransaction(conn: ?*dpiConn, transactionId: [*c]dpiSessionlessTransactionId, timeout: u32, deferRoundTrip: c_int) c_int;
pub extern fn dpiConn_suspendSessionlessTransaction(conn: ?*dpiConn) c_int;
pub extern fn dpiData_getBool(data: [*c]dpiData) c_int;
pub extern fn dpiData_getBytes(data: [*c]dpiData) [*c]dpiBytes;
pub extern fn dpiData_getDouble(data: [*c]dpiData) f64;
pub extern fn dpiData_getFloat(data: [*c]dpiData) f32;
pub extern fn dpiData_getInt64(data: [*c]dpiData) i64;
pub extern fn dpiData_getIntervalDS(data: [*c]dpiData) [*c]dpiIntervalDS;
pub extern fn dpiData_getIntervalYM(data: [*c]dpiData) [*c]dpiIntervalYM;
pub extern fn dpiData_getIsNull(data: [*c]dpiData) c_int;
pub extern fn dpiData_getJson(data: [*c]dpiData) ?*dpiJson;
pub extern fn dpiData_getJsonArray(data: [*c]dpiData) [*c]dpiJsonArray;
pub extern fn dpiData_getJsonObject(data: [*c]dpiData) [*c]dpiJsonObject;
pub extern fn dpiData_getLOB(data: [*c]dpiData) ?*dpiLob;
pub extern fn dpiData_getObject(data: [*c]dpiData) ?*dpiObject;
pub extern fn dpiData_getStmt(data: [*c]dpiData) ?*dpiStmt;
pub extern fn dpiData_getTimestamp(data: [*c]dpiData) [*c]dpiTimestamp;
pub extern fn dpiData_getUint64(data: [*c]dpiData) u64;
pub extern fn dpiData_getVector(data: [*c]dpiData) ?*dpiVector;
pub extern fn dpiData_setBool(data: [*c]dpiData, value: c_int) void;
pub extern fn dpiData_setBytes(data: [*c]dpiData, ptr: [*c]u8, length: u32) void;
pub extern fn dpiData_setDouble(data: [*c]dpiData, value: f64) void;
pub extern fn dpiData_setFloat(data: [*c]dpiData, value: f32) void;
pub extern fn dpiData_setInt64(data: [*c]dpiData, value: i64) void;
pub extern fn dpiData_setIntervalDS(data: [*c]dpiData, days: i32, hours: i32, minutes: i32, seconds: i32, fseconds: i32) void;
pub extern fn dpiData_setIntervalYM(data: [*c]dpiData, years: i32, months: i32) void;
pub extern fn dpiData_setLOB(data: [*c]dpiData, lob: ?*dpiLob) void;
pub extern fn dpiData_setNull(data: [*c]dpiData) void;
pub extern fn dpiData_setObject(data: [*c]dpiData, obj: ?*dpiObject) void;
pub extern fn dpiData_setStmt(data: [*c]dpiData, stmt: ?*dpiStmt) void;
pub extern fn dpiData_setTimestamp(data: [*c]dpiData, year: i16, month: u8, day: u8, hour: u8, minute: u8, second: u8, fsecond: u32, tzHourOffset: i8, tzMinuteOffset: i8) void;
pub extern fn dpiData_setUint64(data: [*c]dpiData, value: u64) void;
pub extern fn dpiDeqOptions_addRef(options: ?*dpiDeqOptions) c_int;
pub extern fn dpiDeqOptions_getCondition(options: ?*dpiDeqOptions, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiDeqOptions_getConsumerName(options: ?*dpiDeqOptions, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiDeqOptions_getCorrelation(options: ?*dpiDeqOptions, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiDeqOptions_getMode(options: ?*dpiDeqOptions, value: [*c]dpiDeqMode) c_int;
pub extern fn dpiDeqOptions_getMsgId(options: ?*dpiDeqOptions, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiDeqOptions_getNavigation(options: ?*dpiDeqOptions, value: [*c]dpiDeqNavigation) c_int;
pub extern fn dpiDeqOptions_getTransformation(options: ?*dpiDeqOptions, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiDeqOptions_getVisibility(options: ?*dpiDeqOptions, value: [*c]dpiVisibility) c_int;
pub extern fn dpiDeqOptions_getWait(options: ?*dpiDeqOptions, value: [*c]u32) c_int;
pub extern fn dpiDeqOptions_release(options: ?*dpiDeqOptions) c_int;
pub extern fn dpiDeqOptions_setCondition(options: ?*dpiDeqOptions, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiDeqOptions_setConsumerName(options: ?*dpiDeqOptions, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiDeqOptions_setCorrelation(options: ?*dpiDeqOptions, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiDeqOptions_setDeliveryMode(options: ?*dpiDeqOptions, value: dpiMessageDeliveryMode) c_int;
pub extern fn dpiDeqOptions_setMode(options: ?*dpiDeqOptions, value: dpiDeqMode) c_int;
pub extern fn dpiDeqOptions_setMsgId(options: ?*dpiDeqOptions, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiDeqOptions_setNavigation(options: ?*dpiDeqOptions, value: dpiDeqNavigation) c_int;
pub extern fn dpiDeqOptions_setTransformation(options: ?*dpiDeqOptions, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiDeqOptions_setVisibility(options: ?*dpiDeqOptions, value: dpiVisibility) c_int;
pub extern fn dpiDeqOptions_setWait(options: ?*dpiDeqOptions, value: u32) c_int;
pub extern fn dpiEnqOptions_addRef(options: ?*dpiEnqOptions) c_int;
pub extern fn dpiEnqOptions_getTransformation(options: ?*dpiEnqOptions, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiEnqOptions_getVisibility(options: ?*dpiEnqOptions, value: [*c]dpiVisibility) c_int;
pub extern fn dpiEnqOptions_release(options: ?*dpiEnqOptions) c_int;
pub extern fn dpiEnqOptions_setDeliveryMode(options: ?*dpiEnqOptions, value: dpiMessageDeliveryMode) c_int;
pub extern fn dpiEnqOptions_setTransformation(options: ?*dpiEnqOptions, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiEnqOptions_setVisibility(options: ?*dpiEnqOptions, value: dpiVisibility) c_int;
pub extern fn dpiJson_addRef(json: ?*dpiJson) c_int;
pub extern fn dpiJson_getValue(json: ?*dpiJson, options: u32, topNode: [*c][*c]dpiJsonNode) c_int;
pub extern fn dpiJson_release(json: ?*dpiJson) c_int;
pub extern fn dpiJson_setFromText(json: ?*dpiJson, value: [*c]const u8, valueLength: u64, flags: u32) c_int;
pub extern fn dpiJson_setValue(json: ?*dpiJson, topNode: [*c]dpiJsonNode) c_int;
pub extern fn dpiLob_addRef(lob: ?*dpiLob) c_int;
pub extern fn dpiLob_close(lob: ?*dpiLob) c_int;
pub extern fn dpiLob_closeResource(lob: ?*dpiLob) c_int;
pub extern fn dpiLob_copy(lob: ?*dpiLob, copiedLob: [*c]?*dpiLob) c_int;
pub extern fn dpiLob_getBufferSize(lob: ?*dpiLob, sizeInChars: u64, sizeInBytes: [*c]u64) c_int;
pub extern fn dpiLob_getChunkSize(lob: ?*dpiLob, size: [*c]u32) c_int;
pub extern fn dpiLob_getDirectoryAndFileName(lob: ?*dpiLob, directoryAlias: [*c][*c]const u8, directoryAliasLength: [*c]u32, fileName: [*c][*c]const u8, fileNameLength: [*c]u32) c_int;
pub extern fn dpiLob_getFileExists(lob: ?*dpiLob, exists: [*c]c_int) c_int;
pub extern fn dpiLob_getIsResourceOpen(lob: ?*dpiLob, isOpen: [*c]c_int) c_int;
pub extern fn dpiLob_getSize(lob: ?*dpiLob, size: [*c]u64) c_int;
pub extern fn dpiLob_getType(lob: ?*dpiLob, @"type": [*c]dpiOracleTypeNum) c_int;
pub extern fn dpiLob_openResource(lob: ?*dpiLob) c_int;
pub extern fn dpiLob_readBytes(lob: ?*dpiLob, offset: u64, amount: u64, value: [*c]u8, valueLength: [*c]u64) c_int;
pub extern fn dpiLob_release(lob: ?*dpiLob) c_int;
pub extern fn dpiLob_setDirectoryAndFileName(lob: ?*dpiLob, directoryAlias: [*c]const u8, directoryAliasLength: u32, fileName: [*c]const u8, fileNameLength: u32) c_int;
pub extern fn dpiLob_setFromBytes(lob: ?*dpiLob, value: [*c]const u8, valueLength: u64) c_int;
pub extern fn dpiLob_trim(lob: ?*dpiLob, newSize: u64) c_int;
pub extern fn dpiLob_writeBytes(lob: ?*dpiLob, offset: u64, value: [*c]const u8, valueLength: u64) c_int;
pub extern fn dpiMsgProps_addRef(props: ?*dpiMsgProps) c_int;
pub extern fn dpiMsgProps_getNumAttempts(props: ?*dpiMsgProps, value: [*c]i32) c_int;
pub extern fn dpiMsgProps_getCorrelation(props: ?*dpiMsgProps, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiMsgProps_getDelay(props: ?*dpiMsgProps, value: [*c]i32) c_int;
pub extern fn dpiMsgProps_getDeliveryMode(props: ?*dpiMsgProps, value: [*c]dpiMessageDeliveryMode) c_int;
pub extern fn dpiMsgProps_getEnqTime(props: ?*dpiMsgProps, value: [*c]dpiTimestamp) c_int;
pub extern fn dpiMsgProps_getExceptionQ(props: ?*dpiMsgProps, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiMsgProps_getExpiration(props: ?*dpiMsgProps, value: [*c]i32) c_int;
pub extern fn dpiMsgProps_getMsgId(props: ?*dpiMsgProps, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiMsgProps_getOriginalMsgId(props: ?*dpiMsgProps, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiMsgProps_getPayload(props: ?*dpiMsgProps, obj: [*c]?*dpiObject, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiMsgProps_getPayloadJson(props: ?*dpiMsgProps, json: [*c]?*dpiJson) c_int;
pub extern fn dpiMsgProps_getPriority(props: ?*dpiMsgProps, value: [*c]i32) c_int;
pub extern fn dpiMsgProps_getState(props: ?*dpiMsgProps, value: [*c]dpiMessageState) c_int;
pub extern fn dpiMsgProps_release(props: ?*dpiMsgProps) c_int;
pub extern fn dpiMsgProps_setCorrelation(props: ?*dpiMsgProps, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiMsgProps_setDelay(props: ?*dpiMsgProps, value: i32) c_int;
pub extern fn dpiMsgProps_setExceptionQ(props: ?*dpiMsgProps, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiMsgProps_setExpiration(props: ?*dpiMsgProps, value: i32) c_int;
pub extern fn dpiMsgProps_setOriginalMsgId(props: ?*dpiMsgProps, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiMsgProps_setPayloadBytes(props: ?*dpiMsgProps, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiMsgProps_setPayloadJson(props: ?*dpiMsgProps, json: ?*dpiJson) c_int;
pub extern fn dpiMsgProps_setPayloadObject(props: ?*dpiMsgProps, obj: ?*dpiObject) c_int;
pub extern fn dpiMsgProps_setPriority(props: ?*dpiMsgProps, value: i32) c_int;
pub extern fn dpiMsgProps_setRecipients(props: ?*dpiMsgProps, recipients: [*c]dpiMsgRecipient, numRecipients: u32) c_int;
pub extern fn dpiObject_addRef(obj: ?*dpiObject) c_int;
pub extern fn dpiObject_appendElement(obj: ?*dpiObject, nativeTypeNum: dpiNativeTypeNum, value: [*c]dpiData) c_int;
pub extern fn dpiObject_copy(obj: ?*dpiObject, copiedObj: [*c]?*dpiObject) c_int;
pub extern fn dpiObject_deleteElementByIndex(obj: ?*dpiObject, index: i32) c_int;
pub extern fn dpiObject_getAttributeValue(obj: ?*dpiObject, attr: ?*dpiObjectAttr, nativeTypeNum: dpiNativeTypeNum, value: [*c]dpiData) c_int;
pub extern fn dpiObject_getElementExistsByIndex(obj: ?*dpiObject, index: i32, exists: [*c]c_int) c_int;
pub extern fn dpiObject_getElementValueByIndex(obj: ?*dpiObject, index: i32, nativeTypeNum: dpiNativeTypeNum, value: [*c]dpiData) c_int;
pub extern fn dpiObject_getFirstIndex(obj: ?*dpiObject, index: [*c]i32, exists: [*c]c_int) c_int;
pub extern fn dpiObject_getLastIndex(obj: ?*dpiObject, index: [*c]i32, exists: [*c]c_int) c_int;
pub extern fn dpiObject_getNextIndex(obj: ?*dpiObject, index: i32, nextIndex: [*c]i32, exists: [*c]c_int) c_int;
pub extern fn dpiObject_getPrevIndex(obj: ?*dpiObject, index: i32, prevIndex: [*c]i32, exists: [*c]c_int) c_int;
pub extern fn dpiObject_getSize(obj: ?*dpiObject, size: [*c]i32) c_int;
pub extern fn dpiObject_release(obj: ?*dpiObject) c_int;
pub extern fn dpiObject_setAttributeValue(obj: ?*dpiObject, attr: ?*dpiObjectAttr, nativeTypeNum: dpiNativeTypeNum, value: [*c]dpiData) c_int;
pub extern fn dpiObject_setElementValueByIndex(obj: ?*dpiObject, index: i32, nativeTypeNum: dpiNativeTypeNum, value: [*c]dpiData) c_int;
pub extern fn dpiObject_trim(obj: ?*dpiObject, numToTrim: u32) c_int;
pub extern fn dpiObjectAttr_addRef(attr: ?*dpiObjectAttr) c_int;
pub extern fn dpiObjectAttr_getInfo(attr: ?*dpiObjectAttr, info: [*c]dpiObjectAttrInfo) c_int;
pub extern fn dpiObjectAttr_release(attr: ?*dpiObjectAttr) c_int;
pub extern fn dpiObjectType_addRef(objType: ?*dpiObjectType) c_int;
pub extern fn dpiObjectType_createObject(objType: ?*dpiObjectType, obj: [*c]?*dpiObject) c_int;
pub extern fn dpiObjectType_getAttributes(objType: ?*dpiObjectType, numAttributes: u16, attributes: [*c]?*dpiObjectAttr) c_int;
pub extern fn dpiObjectType_getInfo(objType: ?*dpiObjectType, info: [*c]dpiObjectTypeInfo) c_int;
pub extern fn dpiObjectType_release(objType: ?*dpiObjectType) c_int;
pub extern fn dpiPool_acquireConnection(pool: ?*dpiPool, userName: [*c]const u8, userNameLength: u32, password: [*c]const u8, passwordLength: u32, createParams: [*c]dpiConnCreateParams, conn: [*c]?*dpiConn) c_int;
pub extern fn dpiPool_addRef(pool: ?*dpiPool) c_int;
pub extern fn dpiPool_close(pool: ?*dpiPool, closeMode: dpiPoolCloseMode) c_int;
pub extern fn dpiPool_create(context: ?*const dpiContext, userName: [*c]const u8, userNameLength: u32, password: [*c]const u8, passwordLength: u32, connectString: [*c]const u8, connectStringLength: u32, commonParams: [*c]const dpiCommonCreateParams, createParams: [*c]dpiPoolCreateParams, pool: [*c]?*dpiPool) c_int;
pub extern fn dpiPool_getBusyCount(pool: ?*dpiPool, value: [*c]u32) c_int;
pub extern fn dpiPool_getEncodingInfo(pool: ?*dpiPool, info: [*c]dpiEncodingInfo) c_int;
pub extern fn dpiPool_getGetMode(pool: ?*dpiPool, value: [*c]dpiPoolGetMode) c_int;
pub extern fn dpiPool_getMaxLifetimeSession(pool: ?*dpiPool, value: [*c]u32) c_int;
pub extern fn dpiPool_getMaxSessionsPerShard(pool: ?*dpiPool, value: [*c]u32) c_int;
pub extern fn dpiPool_getOpenCount(pool: ?*dpiPool, value: [*c]u32) c_int;
pub extern fn dpiPool_getSodaMetadataCache(pool: ?*dpiPool, enabled: [*c]c_int) c_int;
pub extern fn dpiPool_getStmtCacheSize(pool: ?*dpiPool, cacheSize: [*c]u32) c_int;
pub extern fn dpiPool_getTimeout(pool: ?*dpiPool, value: [*c]u32) c_int;
pub extern fn dpiPool_getWaitTimeout(pool: ?*dpiPool, value: [*c]u32) c_int;
pub extern fn dpiPool_getPingInterval(pool: ?*dpiPool, value: [*c]c_int) c_int;
pub extern fn dpiPool_release(pool: ?*dpiPool) c_int;
pub extern fn dpiPool_setAccessToken(pool: ?*dpiPool, params: [*c]dpiAccessToken) c_int;
pub extern fn dpiPool_setGetMode(pool: ?*dpiPool, value: dpiPoolGetMode) c_int;
pub extern fn dpiPool_setMaxLifetimeSession(pool: ?*dpiPool, value: u32) c_int;
pub extern fn dpiPool_setMaxSessionsPerShard(pool: ?*dpiPool, value: u32) c_int;
pub extern fn dpiPool_setSodaMetadataCache(pool: ?*dpiPool, enabled: c_int) c_int;
pub extern fn dpiPool_setStmtCacheSize(pool: ?*dpiPool, cacheSize: u32) c_int;
pub extern fn dpiPool_setTimeout(pool: ?*dpiPool, value: u32) c_int;
pub extern fn dpiPool_setWaitTimeout(pool: ?*dpiPool, value: u32) c_int;
pub extern fn dpiPool_setPingInterval(pool: ?*dpiPool, value: c_int) c_int;
pub extern fn dpiQueue_addRef(queue: ?*dpiQueue) c_int;
pub extern fn dpiQueue_deqMany(queue: ?*dpiQueue, numProps: [*c]u32, props: [*c]?*dpiMsgProps) c_int;
pub extern fn dpiQueue_deqOne(queue: ?*dpiQueue, props: [*c]?*dpiMsgProps) c_int;
pub extern fn dpiQueue_enqMany(queue: ?*dpiQueue, numProps: u32, props: [*c]?*dpiMsgProps) c_int;
pub extern fn dpiQueue_enqOne(queue: ?*dpiQueue, props: ?*dpiMsgProps) c_int;
pub extern fn dpiQueue_getDeqOptions(queue: ?*dpiQueue, options: [*c]?*dpiDeqOptions) c_int;
pub extern fn dpiQueue_getEnqOptions(queue: ?*dpiQueue, options: [*c]?*dpiEnqOptions) c_int;
pub extern fn dpiQueue_release(queue: ?*dpiQueue) c_int;
pub extern fn dpiPool_reconfigure(pool: ?*dpiPool, minSessions: u32, maxSessions: u32, sessionIncrement: u32) c_int;
pub extern fn dpiSodaColl_addRef(coll: ?*dpiSodaColl) c_int;
pub extern fn dpiSodaColl_createIndex(coll: ?*dpiSodaColl, indexSpec: [*c]const u8, indexSpecLength: u32, flags: u32) c_int;
pub extern fn dpiSodaColl_drop(coll: ?*dpiSodaColl, flags: u32, isDropped: [*c]c_int) c_int;
pub extern fn dpiSodaColl_dropIndex(coll: ?*dpiSodaColl, name: [*c]const u8, nameLength: u32, flags: u32, isDropped: [*c]c_int) c_int;
pub extern fn dpiSodaColl_find(coll: ?*dpiSodaColl, options: [*c]const dpiSodaOperOptions, flags: u32, cursor: [*c]?*dpiSodaDocCursor) c_int;
pub extern fn dpiSodaColl_findOne(coll: ?*dpiSodaColl, options: [*c]const dpiSodaOperOptions, flags: u32, doc: [*c]?*dpiSodaDoc) c_int;
pub extern fn dpiSodaColl_getDataGuide(coll: ?*dpiSodaColl, flags: u32, doc: [*c]?*dpiSodaDoc) c_int;
pub extern fn dpiSodaColl_getDocCount(coll: ?*dpiSodaColl, options: [*c]const dpiSodaOperOptions, flags: u32, count: [*c]u64) c_int;
pub extern fn dpiSodaColl_getMetadata(coll: ?*dpiSodaColl, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiSodaColl_getName(coll: ?*dpiSodaColl, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiSodaColl_insertMany(coll: ?*dpiSodaColl, numDocs: u32, docs: [*c]?*dpiSodaDoc, flags: u32, insertedDocs: [*c]?*dpiSodaDoc) c_int;
pub extern fn dpiSodaColl_insertManyWithOptions(coll: ?*dpiSodaColl, numDocs: u32, docs: [*c]?*dpiSodaDoc, options: [*c]dpiSodaOperOptions, flags: u32, insertedDocs: [*c]?*dpiSodaDoc) c_int;
pub extern fn dpiSodaColl_insertOne(coll: ?*dpiSodaColl, doc: ?*dpiSodaDoc, flags: u32, insertedDoc: [*c]?*dpiSodaDoc) c_int;
pub extern fn dpiSodaColl_insertOneWithOptions(coll: ?*dpiSodaColl, doc: ?*dpiSodaDoc, options: [*c]dpiSodaOperOptions, flags: u32, insertedDoc: [*c]?*dpiSodaDoc) c_int;
pub extern fn dpiSodaColl_listIndexes(coll: ?*dpiSodaColl, flags: u32, list: [*c]dpiStringList) c_int;
pub extern fn dpiSodaColl_release(coll: ?*dpiSodaColl) c_int;
pub extern fn dpiSodaColl_remove(coll: ?*dpiSodaColl, options: [*c]const dpiSodaOperOptions, flags: u32, count: [*c]u64) c_int;
pub extern fn dpiSodaColl_replaceOne(coll: ?*dpiSodaColl, options: [*c]const dpiSodaOperOptions, doc: ?*dpiSodaDoc, flags: u32, replaced: [*c]c_int, replacedDoc: [*c]?*dpiSodaDoc) c_int;
pub extern fn dpiSodaColl_save(coll: ?*dpiSodaColl, doc: ?*dpiSodaDoc, flags: u32, savedDoc: [*c]?*dpiSodaDoc) c_int;
pub extern fn dpiSodaColl_saveWithOptions(coll: ?*dpiSodaColl, doc: ?*dpiSodaDoc, options: [*c]dpiSodaOperOptions, flags: u32, savedDoc: [*c]?*dpiSodaDoc) c_int;
pub extern fn dpiSodaColl_truncate(coll: ?*dpiSodaColl) c_int;
pub extern fn dpiSodaCollCursor_addRef(cursor: ?*dpiSodaCollCursor) c_int;
pub extern fn dpiSodaCollCursor_close(cursor: ?*dpiSodaCollCursor) c_int;
pub extern fn dpiSodaCollCursor_getNext(cursor: ?*dpiSodaCollCursor, flags: u32, coll: [*c]?*dpiSodaColl) c_int;
pub extern fn dpiSodaCollCursor_release(cursor: ?*dpiSodaCollCursor) c_int;
pub extern fn dpiSodaDb_addRef(db: ?*dpiSodaDb) c_int;
pub extern fn dpiSodaDb_createCollection(db: ?*dpiSodaDb, name: [*c]const u8, nameLength: u32, metadata: [*c]const u8, metadataLength: u32, flags: u32, coll: [*c]?*dpiSodaColl) c_int;
pub extern fn dpiSodaDb_createDocument(db: ?*dpiSodaDb, key: [*c]const u8, keyLength: u32, content: [*c]const u8, contentLength: u32, mediaType: [*c]const u8, mediaTypeLength: u32, flags: u32, doc: [*c]?*dpiSodaDoc) c_int;
pub extern fn dpiSodaDb_createJsonDocument(db: ?*dpiSodaDb, key: [*c]const u8, keyLength: u32, content: [*c]const dpiJsonNode, flags: u32, doc: [*c]?*dpiSodaDoc) c_int;
pub extern fn dpiSodaDb_getCollections(db: ?*dpiSodaDb, startName: [*c]const u8, startNameLength: u32, flags: u32, cursor: [*c]?*dpiSodaCollCursor) c_int;
pub extern fn dpiSodaDb_getCollectionNames(db: ?*dpiSodaDb, startName: [*c]const u8, startNameLength: u32, limit: u32, flags: u32, names: [*c]dpiStringList) c_int;
pub extern fn dpiSodaDb_openCollection(db: ?*dpiSodaDb, name: [*c]const u8, nameLength: u32, flags: u32, coll: [*c]?*dpiSodaColl) c_int;
pub extern fn dpiSodaDb_release(db: ?*dpiSodaDb) c_int;
pub extern fn dpiSodaDoc_addRef(cursor: ?*dpiSodaDoc) c_int;
pub extern fn dpiSodaDoc_getContent(doc: ?*dpiSodaDoc, value: [*c][*c]const u8, valueLength: [*c]u32, encoding: [*c][*c]const u8) c_int;
pub extern fn dpiSodaDoc_getCreatedOn(doc: ?*dpiSodaDoc, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiSodaDoc_getIsJson(doc: ?*dpiSodaDoc, isJson: [*c]c_int) c_int;
pub extern fn dpiSodaDoc_getJsonContent(doc: ?*dpiSodaDoc, value: [*c]?*dpiJson) c_int;
pub extern fn dpiSodaDoc_getKey(doc: ?*dpiSodaDoc, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiSodaDoc_getLastModified(doc: ?*dpiSodaDoc, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiSodaDoc_getMediaType(doc: ?*dpiSodaDoc, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiSodaDoc_getVersion(doc: ?*dpiSodaDoc, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiSodaDoc_release(doc: ?*dpiSodaDoc) c_int;
pub extern fn dpiSodaDocCursor_addRef(cursor: ?*dpiSodaDocCursor) c_int;
pub extern fn dpiSodaDocCursor_close(cursor: ?*dpiSodaDocCursor) c_int;
pub extern fn dpiSodaDocCursor_getNext(cursor: ?*dpiSodaDocCursor, flags: u32, doc: [*c]?*dpiSodaDoc) c_int;
pub extern fn dpiSodaDocCursor_release(cursor: ?*dpiSodaDocCursor) c_int;
pub extern fn dpiStmt_addRef(stmt: ?*dpiStmt) c_int;
pub extern fn dpiStmt_bindByName(stmt: ?*dpiStmt, name: [*c]const u8, nameLength: u32, @"var": ?*dpiVar) c_int;
pub extern fn dpiStmt_bindByPos(stmt: ?*dpiStmt, pos: u32, @"var": ?*dpiVar) c_int;
pub extern fn dpiStmt_bindValueByName(stmt: ?*dpiStmt, name: [*c]const u8, nameLength: u32, nativeTypeNum: dpiNativeTypeNum, data: [*c]dpiData) c_int;
pub extern fn dpiStmt_bindValueByPos(stmt: ?*dpiStmt, pos: u32, nativeTypeNum: dpiNativeTypeNum, data: [*c]dpiData) c_int;
pub extern fn dpiStmt_close(stmt: ?*dpiStmt, tag: [*c]const u8, tagLength: u32) c_int;
pub extern fn dpiStmt_define(stmt: ?*dpiStmt, pos: u32, @"var": ?*dpiVar) c_int;
pub extern fn dpiStmt_defineValue(stmt: ?*dpiStmt, pos: u32, oracleTypeNum: dpiOracleTypeNum, nativeTypeNum: dpiNativeTypeNum, size: u32, sizeIsBytes: c_int, objType: ?*dpiObjectType) c_int;
pub extern fn dpiStmt_execute(stmt: ?*dpiStmt, mode: dpiExecMode, numQueryColumns: [*c]u32) c_int;
pub extern fn dpiStmt_executeMany(stmt: ?*dpiStmt, mode: dpiExecMode, numIters: u32) c_int;
pub extern fn dpiStmt_fetch(stmt: ?*dpiStmt, found: [*c]c_int, bufferRowIndex: [*c]u32) c_int;
pub extern fn dpiStmt_fetchRows(stmt: ?*dpiStmt, maxRows: u32, bufferRowIndex: [*c]u32, numRowsFetched: [*c]u32, moreRows: [*c]c_int) c_int;
pub extern fn dpiStmt_getBatchErrorCount(stmt: ?*dpiStmt, count: [*c]u32) c_int;
pub extern fn dpiStmt_getBatchErrors(stmt: ?*dpiStmt, numErrors: u32, errors: [*c]dpiErrorInfo) c_int;
pub extern fn dpiStmt_getBindCount(stmt: ?*dpiStmt, count: [*c]u32) c_int;
pub extern fn dpiStmt_getBindNames(stmt: ?*dpiStmt, numBindNames: [*c]u32, bindNames: [*c][*c]const u8, bindNameLengths: [*c]u32) c_int;
pub extern fn dpiStmt_getFetchArraySize(stmt: ?*dpiStmt, arraySize: [*c]u32) c_int;
pub extern fn dpiStmt_getHandle(stmt: ?*dpiStmt, handle: [*c]?*anyopaque) c_int;
pub extern fn dpiStmt_getImplicitResult(stmt: ?*dpiStmt, implicitResult: [*c]?*dpiStmt) c_int;
pub extern fn dpiStmt_getInfo(stmt: ?*dpiStmt, info: [*c]dpiStmtInfo) c_int;
pub extern fn dpiStmt_getLastRowid(stmt: ?*dpiStmt, rowid: [*c]?*dpiRowid) c_int;
pub extern fn dpiStmt_getNumQueryColumns(stmt: ?*dpiStmt, numQueryColumns: [*c]u32) c_int;
pub extern fn dpiStmt_getOciAttr(stmt: ?*dpiStmt, attribute: u32, value: [*c]dpiDataBuffer, valueLength: [*c]u32) c_int;
pub extern fn dpiStmt_getPrefetchRows(stmt: ?*dpiStmt, numRows: [*c]u32) c_int;
pub extern fn dpiStmt_getQueryInfo(stmt: ?*dpiStmt, pos: u32, info: [*c]dpiQueryInfo) c_int;
pub extern fn dpiStmt_getQueryValue(stmt: ?*dpiStmt, pos: u32, nativeTypeNum: [*c]dpiNativeTypeNum, data: [*c][*c]dpiData) c_int;
pub extern fn dpiStmt_getRowCount(stmt: ?*dpiStmt, count: [*c]u64) c_int;
pub extern fn dpiStmt_getRowCounts(stmt: ?*dpiStmt, numRowCounts: [*c]u32, rowCounts: [*c][*c]u64) c_int;
pub extern fn dpiStmt_getSubscrQueryId(stmt: ?*dpiStmt, queryId: [*c]u64) c_int;
pub extern fn dpiStmt_release(stmt: ?*dpiStmt) c_int;
pub extern fn dpiStmt_scroll(stmt: ?*dpiStmt, mode: dpiFetchMode, offset: i32, rowCountOffset: i32) c_int;
pub extern fn dpiStmt_setFetchArraySize(stmt: ?*dpiStmt, arraySize: u32) c_int;
pub extern fn dpiStmt_setOciAttr(stmt: ?*dpiStmt, attribute: u32, value: ?*anyopaque, valueLength: u32) c_int;
pub extern fn dpiStmt_setPrefetchRows(stmt: ?*dpiStmt, numRows: u32) c_int;
pub extern fn dpiStmt_deleteFromCache(stmt: ?*dpiStmt) c_int;
pub extern fn dpiRowid_addRef(rowid: ?*dpiRowid) c_int;
pub extern fn dpiRowid_getStringValue(rowid: ?*dpiRowid, value: [*c][*c]const u8, valueLength: [*c]u32) c_int;
pub extern fn dpiRowid_release(subscr: ?*dpiRowid) c_int;
pub extern fn dpiSubscr_addRef(subscr: ?*dpiSubscr) c_int;
pub extern fn dpiSubscr_prepareStmt(subscr: ?*dpiSubscr, sql: [*c]const u8, sqlLength: u32, stmt: [*c]?*dpiStmt) c_int;
pub extern fn dpiSubscr_release(subscr: ?*dpiSubscr) c_int;
pub extern fn dpiVar_addRef(@"var": ?*dpiVar) c_int;
pub extern fn dpiVar_copyData(@"var": ?*dpiVar, pos: u32, sourceVar: ?*dpiVar, sourcePos: u32) c_int;
pub extern fn dpiVar_getNumElementsInArray(@"var": ?*dpiVar, numElements: [*c]u32) c_int;
pub extern fn dpiVar_getReturnedData(@"var": ?*dpiVar, pos: u32, numElements: [*c]u32, data: [*c][*c]dpiData) c_int;
pub extern fn dpiVar_getSizeInBytes(@"var": ?*dpiVar, sizeInBytes: [*c]u32) c_int;
pub extern fn dpiVar_release(@"var": ?*dpiVar) c_int;
pub extern fn dpiVar_setFromBytes(@"var": ?*dpiVar, pos: u32, value: [*c]const u8, valueLength: u32) c_int;
pub extern fn dpiVar_setFromJson(@"var": ?*dpiVar, pos: u32, json: ?*dpiJson) c_int;
pub extern fn dpiVar_setFromLob(@"var": ?*dpiVar, pos: u32, lob: ?*dpiLob) c_int;
pub extern fn dpiVar_setFromObject(@"var": ?*dpiVar, pos: u32, obj: ?*dpiObject) c_int;
pub extern fn dpiVar_setFromRowid(@"var": ?*dpiVar, pos: u32, rowid: ?*dpiRowid) c_int;
pub extern fn dpiVar_setFromStmt(@"var": ?*dpiVar, pos: u32, stmt: ?*dpiStmt) c_int;
pub extern fn dpiVar_setFromVector(@"var": ?*dpiVar, pos: u32, vector: ?*dpiVector) c_int;
pub extern fn dpiVar_setNumElementsInArray(@"var": ?*dpiVar, numElements: u32) c_int;
pub extern fn dpiVector_addRef(vector: ?*dpiVector) c_int;
pub extern fn dpiVector_getValue(vector: ?*dpiVector, info: [*c]dpiVectorInfo) c_int;
pub extern fn dpiVector_release(vector: ?*dpiVector) c_int;
pub extern fn dpiVector_setValue(vector: ?*dpiVector, info: [*c]dpiVectorInfo) c_int;

pub const __VERSION__ = "Aro aro-zig";
pub const __Aro__ = "";
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __STDC_EMBED_NOT_FOUND__ = @as(c_int, 0);
pub const __STDC_EMBED_FOUND__ = @as(c_int, 1);
pub const __STDC_EMBED_EMPTY__ = @as(c_int, 2);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __GNUC__ = @as(c_int, 7);
pub const __GNUC_MINOR__ = @as(c_int, 1);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 0);
pub const __ARO_EMULATE_NO__ = @as(c_int, 0);
pub const __ARO_EMULATE_CLANG__ = @as(c_int, 1);
pub const __ARO_EMULATE_GCC__ = @as(c_int, 2);
pub const __ARO_EMULATE_MSVC__ = @as(c_int, 3);
pub const __ARO_EMULATE__ = __ARO_EMULATE_GCC__;
pub inline fn __building_module(x: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &x;
    return @as(c_int, 0);
}
pub const linux = @as(c_int, 1);
pub const __linux = @as(c_int, 1);
pub const __linux__ = @as(c_int, 1);
pub const unix = @as(c_int, 1);
pub const __unix = @as(c_int, 1);
pub const __unix__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `address_space`");
// <builtin>:33:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `address_space`");
// <builtin>:34:9
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __AES__ = @as(c_int, 1);
pub const __VAES__ = @as(c_int, 1);
pub const __PCLMUL__ = @as(c_int, 1);
pub const __VPCLMULQDQ__ = @as(c_int, 1);
pub const __LZCNT__ = @as(c_int, 1);
pub const __RDRND__ = @as(c_int, 1);
pub const __FSGSBASE__ = @as(c_int, 1);
pub const __BMI__ = @as(c_int, 1);
pub const __BMI2__ = @as(c_int, 1);
pub const __POPCNT__ = @as(c_int, 1);
pub const __PRFCHW__ = @as(c_int, 1);
pub const __RDSEED__ = @as(c_int, 1);
pub const __ADX__ = @as(c_int, 1);
pub const __MWAITX__ = @as(c_int, 1);
pub const __MOVBE__ = @as(c_int, 1);
pub const __SSE4A__ = @as(c_int, 1);
pub const __FMA__ = @as(c_int, 1);
pub const __F16C__ = @as(c_int, 1);
pub const __SHA__ = @as(c_int, 1);
pub const __FXSR__ = @as(c_int, 1);
pub const __XSAVE__ = @as(c_int, 1);
pub const __XSAVEOPT__ = @as(c_int, 1);
pub const __XSAVEC__ = @as(c_int, 1);
pub const __XSAVES__ = @as(c_int, 1);
pub const __PKU__ = @as(c_int, 1);
pub const __CLFLUSHOPT__ = @as(c_int, 1);
pub const __CLWB__ = @as(c_int, 1);
pub const __WBNOINVD__ = @as(c_int, 1);
pub const __SHSTK__ = @as(c_int, 1);
pub const __CLZERO__ = @as(c_int, 1);
pub const __RDPID__ = @as(c_int, 1);
pub const __RDPRU__ = @as(c_int, 1);
pub const __INVPCID__ = @as(c_int, 1);
pub const __CRC32__ = @as(c_int, 1);
pub const __AVX2__ = @as(c_int, 1);
pub const __AVX__ = @as(c_int, 1);
pub const __SSE4_2__ = @as(c_int, 1);
pub const __SSE4_1__ = @as(c_int, 1);
pub const __SSSE3__ = @as(c_int, 1);
pub const __SSE3__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __FLOAT128__ = @as(c_int, 1);
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const __ELF__ = @as(c_int, 1);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __ATOMIC_BOOL_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_WINT_T_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_SHORT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_INT_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_LLONG_LOCK_FREE = @as(c_int, 1);
pub const __ATOMIC_POINTER_LOCK_FREE = @as(c_int, 1);
pub const __WINT_UNSIGNED__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SCHAR_WIDTH__ = @as(c_int, 8);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __LONG_LONG_WIDTH__ = @as(c_int, 64);
pub const __WCHAR_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIG_ATOMIC_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __BITINT_MAXWIDTH__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 10);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTPTR_TYPE__ = c_long;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`");
// <builtin>:157:9
pub const __INTMAX_C = __helpers.L_SUFFIX;
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`");
// <builtin>:160:9
pub const __UINTMAX_C = __helpers.UL_SUFFIX;
pub const __PTRDIFF_TYPE__ = c_long;
pub const __SIZE_TYPE__ = c_ulong;
pub const __WCHAR_TYPE__ = c_int;
pub const __WINT_TYPE__ = c_uint;
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub inline fn __INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub inline fn __INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub inline fn __INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT64_TYPE__ = c_long;
pub const __INT64_FMTd__ = "ld";
pub const __INT64_FMTi__ = "li";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`");
// <builtin>:186:9
pub const __INT64_C = __helpers.L_SUFFIX;
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub inline fn __UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub inline fn __UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`");
// <builtin>:211:9
pub const __UINT32_C = __helpers.U_SUFFIX;
pub const __UINT32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulong;
pub const __UINT64_FMTo__ = "lo";
pub const __UINT64_FMTu__ = "lu";
pub const __UINT64_FMTx__ = "lx";
pub const __UINT64_FMTX__ = "lX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`");
// <builtin>:220:9
pub const __UINT64_C = __helpers.UL_SUFFIX;
pub const __UINT64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __INT64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const INT_LEAST8_FMTd__ = "hhd";
pub const INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const UINT_LEAST8_FMTo__ = "hho";
pub const UINT_LEAST8_FMTu__ = "hhu";
pub const UINT_LEAST8_FMTx__ = "hhx";
pub const UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const INT_FAST8_FMTd__ = "hhd";
pub const INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const UINT_FAST8_FMTo__ = "hho";
pub const UINT_FAST8_FMTu__ = "hhu";
pub const UINT_FAST8_FMTx__ = "hhx";
pub const UINT_FAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const INT_LEAST16_FMTd__ = "hd";
pub const INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST16_FMTo__ = "ho";
pub const UINT_LEAST16_FMTu__ = "hu";
pub const UINT_LEAST16_FMTx__ = "hx";
pub const UINT_LEAST16_FMTX__ = "hX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const INT_FAST16_FMTd__ = "hd";
pub const INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_FAST16_FMTo__ = "ho";
pub const UINT_FAST16_FMTu__ = "hu";
pub const UINT_FAST16_FMTx__ = "hx";
pub const UINT_FAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const INT_LEAST32_FMTd__ = "d";
pub const INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST32_FMTo__ = "o";
pub const UINT_LEAST32_FMTu__ = "u";
pub const UINT_LEAST32_FMTx__ = "x";
pub const UINT_LEAST32_FMTX__ = "X";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const INT_FAST32_FMTd__ = "d";
pub const INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_FAST32_FMTo__ = "o";
pub const UINT_FAST32_FMTu__ = "u";
pub const UINT_FAST32_FMTx__ = "x";
pub const UINT_FAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_long;
pub const __INT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const INT_LEAST64_FMTd__ = "ld";
pub const INT_LEAST64_FMTi__ = "li";
pub const __UINT_LEAST64_TYPE__ = c_ulong;
pub const __UINT_LEAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_LEAST64_FMTo__ = "lo";
pub const UINT_LEAST64_FMTu__ = "lu";
pub const UINT_LEAST64_FMTx__ = "lx";
pub const UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST64_TYPE__ = c_long;
pub const __INT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const INT_FAST64_FMTd__ = "ld";
pub const INT_FAST64_FMTi__ = "li";
pub const __UINT_FAST64_TYPE__ = c_ulong;
pub const __UINT_FAST64_MAX__ = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_FMTo__ = "lo";
pub const UINT_FAST64_FMTu__ = "lu";
pub const UINT_FAST64_FMTx__ = "lx";
pub const UINT_FAST64_FMTX__ = "lX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_HAS_DENORM__ = "";
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = "";
pub const __FLT16_HAS_QUIET_NAN__ = "";
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = "";
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = "";
pub const __FLT_HAS_QUIET_NAN__ = "";
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = "";
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = "";
pub const __DBL_HAS_QUIET_NAN__ = "";
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_HAS_DENORM__ = "";
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = "";
pub const __LDBL_HAS_QUIET_NAN__ = "";
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __FLT_EVAL_METHOD__ = @as(c_int, 0);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const DPI_PUBLIC = "";
pub const __CLANG_STDINT_H = "";
pub const _STDINT_H = @as(c_int, 1);
pub const _FEATURES_H = @as(c_int, 1);
pub const __KERNEL_STRICT_NAMES = "";
pub inline fn __GNUC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub inline fn __glibc_clang_prereq(maj: anytype, min: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &maj;
    _ = &min;
    return @as(c_int, 0);
}
pub const __GLIBC_USE = @compileError("unable to translate macro: undefined identifier `__GLIBC_USE_`");
// /usr/include/features.h:186:9
pub const _DEFAULT_SOURCE = @as(c_int, 1);
pub const __GLIBC_USE_ISOC2X = @as(c_int, 0);
pub const __USE_ISOC11 = @as(c_int, 1);
pub const __USE_POSIX_IMPLICITLY = @as(c_int, 1);
pub const _POSIX_SOURCE = @as(c_int, 1);
pub const _POSIX_C_SOURCE = @as(c_long, 200809);
pub const __USE_POSIX = @as(c_int, 1);
pub const __USE_POSIX2 = @as(c_int, 1);
pub const __USE_POSIX199309 = @as(c_int, 1);
pub const __USE_POSIX199506 = @as(c_int, 1);
pub const __USE_XOPEN2K = @as(c_int, 1);
pub const __USE_ISOC95 = @as(c_int, 1);
pub const __USE_ISOC99 = @as(c_int, 1);
pub const __USE_XOPEN2K8 = @as(c_int, 1);
pub const _ATFILE_SOURCE = @as(c_int, 1);
pub const __WORDSIZE = @as(c_int, 64);
pub const __WORDSIZE_TIME64_COMPAT32 = @as(c_int, 1);
pub const __SYSCALL_WORDSIZE = @as(c_int, 64);
pub const __TIMESIZE = __WORDSIZE;
pub const __USE_MISC = @as(c_int, 1);
pub const __USE_ATFILE = @as(c_int, 1);
pub const __USE_FORTIFY_LEVEL = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_GETS = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_SCANF = @as(c_int, 0);
pub const _STDC_PREDEF_H = @as(c_int, 1);
pub const __STDC_IEC_559__ = @as(c_int, 1);
pub const __STDC_IEC_60559_BFP__ = @as(c_long, 201404);
pub const __STDC_IEC_559_COMPLEX__ = @as(c_int, 1);
pub const __STDC_IEC_60559_COMPLEX__ = @as(c_long, 201404);
pub const __STDC_ISO_10646__ = @as(c_long, 201706);
pub const __GNU_LIBRARY__ = @as(c_int, 6);
pub const __GLIBC__ = @as(c_int, 2);
pub const __GLIBC_MINOR__ = @as(c_int, 35);
pub inline fn __GLIBC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub const _SYS_CDEFS_H = @as(c_int, 1);
pub const __glibc_has_attribute = @compileError("unable to translate macro: undefined identifier `__has_attribute`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:45:10
pub inline fn __glibc_has_builtin(name: anytype) @TypeOf(__builtin.has_builtin(name)) {
    _ = &name;
    return __builtin.has_builtin(name);
}
pub const __glibc_has_extension = @compileError("unable to translate macro: undefined identifier `__has_extension`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:55:10
pub const __LEAF = @compileError("unable to translate macro: undefined identifier `__leaf__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:65:11
pub const __LEAF_ATTR = @compileError("unable to translate macro: undefined identifier `__leaf__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:66:11
pub const __THROW = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:79:11
pub const __THROWNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:80:11
pub const __NTH = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:81:11
pub const __NTHNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:82:11
pub inline fn __P(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub inline fn __PMT(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub const __CONCAT = @compileError("unable to translate C expr: unexpected token '##'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:124:9
pub const __STRING = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:125:9
pub const __ptr_t = ?*anyopaque;
pub const __BEGIN_DECLS = "";
pub const __END_DECLS = "";
pub inline fn __bos(ptr: anytype) @TypeOf(__builtin.object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1))) {
    _ = &ptr;
    return __builtin.object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1));
}
pub inline fn __bos0(ptr: anytype) @TypeOf(__builtin.object_size(ptr, @as(c_int, 0))) {
    _ = &ptr;
    return __builtin.object_size(ptr, @as(c_int, 0));
}
pub inline fn __glibc_objsize0(__o: anytype) @TypeOf(__bos0(__o)) {
    _ = &__o;
    return __bos0(__o);
}
pub inline fn __glibc_objsize(__o: anytype) @TypeOf(__bos(__o)) {
    _ = &__o;
    return __bos(__o);
}
pub inline fn __glibc_safe_len_cond(__l: anytype, __s: anytype, __osz: anytype) @TypeOf(__l <= __helpers.div(__osz, __s)) {
    _ = &__l;
    _ = &__s;
    _ = &__osz;
    return __l <= __helpers.div(__osz, __s);
}
pub const __glibc_unsigned_or_positive = @compileError("unable to translate C expr: unexpected token '__typeof'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:160:9
pub inline fn __glibc_safe_or_unknown_len(__l: anytype, __s: anytype, __osz: anytype) @TypeOf(((__glibc_unsigned_or_positive(__l) != 0) and (__builtin.constant_p(__glibc_safe_len_cond(__SIZE_TYPE__(__l), __s, __osz)) != 0)) and (__glibc_safe_len_cond(__SIZE_TYPE__(__l), __s, __osz) != 0)) {
    _ = &__l;
    _ = &__s;
    _ = &__osz;
    return ((__glibc_unsigned_or_positive(__l) != 0) and (__builtin.constant_p(__glibc_safe_len_cond(__SIZE_TYPE__(__l), __s, __osz)) != 0)) and (__glibc_safe_len_cond(__SIZE_TYPE__(__l), __s, __osz) != 0);
}
pub inline fn __glibc_unsafe_len(__l: anytype, __s: anytype, __osz: anytype) @TypeOf(((__glibc_unsigned_or_positive(__l) != 0) and (__builtin.constant_p(__glibc_safe_len_cond(__SIZE_TYPE__(__l), __s, __osz)) != 0)) and !(__glibc_safe_len_cond(__SIZE_TYPE__(__l), __s, __osz) != 0)) {
    _ = &__l;
    _ = &__s;
    _ = &__osz;
    return ((__glibc_unsigned_or_positive(__l) != 0) and (__builtin.constant_p(__glibc_safe_len_cond(__SIZE_TYPE__(__l), __s, __osz)) != 0)) and !(__glibc_safe_len_cond(__SIZE_TYPE__(__l), __s, __osz) != 0);
}
pub const __glibc_fortify = @compileError("unable to translate macro: undefined identifier `__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:185:9
pub const __glibc_fortify_n = @compileError("unable to translate macro: undefined identifier `__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:195:9
pub const __warnattr = @compileError("unable to translate macro: undefined identifier `__warning__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:203:10
pub const __errordecl = @compileError("unable to translate macro: undefined identifier `__error__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:204:10
pub const __flexarr = @compileError("unable to translate C expr: unexpected token '['");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:216:10
pub const __glibc_c99_flexarr_available = @as(c_int, 1);
pub const __REDIRECT = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:247:10
pub const __REDIRECT_NTH = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:254:11
pub const __REDIRECT_NTHNL = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:256:11
pub const __ASMNAME = @compileError("unable to translate macro: undefined identifier `__USER_LABEL_PREFIX__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:259:10
pub inline fn __ASMNAME2(prefix: anytype, cname: anytype) @TypeOf(__STRING(prefix) ++ cname) {
    _ = &prefix;
    _ = &cname;
    return __STRING(prefix) ++ cname;
}
pub const __attribute_malloc__ = @compileError("unable to translate macro: undefined identifier `__malloc__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:281:10
pub const __attribute_alloc_size__ = @compileError("unable to translate macro: undefined identifier `__alloc_size__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:289:10
pub const __attribute_alloc_align__ = @compileError("unable to translate macro: undefined identifier `__alloc_align__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:298:10
pub const __attribute_pure__ = @compileError("unable to translate macro: undefined identifier `__pure__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:308:10
pub const __attribute_const__ = @compileError("unable to translate C expr: unexpected token '__attribute__'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:315:10
pub const __attribute_maybe_unused__ = @compileError("unable to translate macro: undefined identifier `__unused__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:321:10
pub const __attribute_used__ = @compileError("unable to translate macro: undefined identifier `__used__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:330:10
pub const __attribute_noinline__ = @compileError("unable to translate macro: undefined identifier `__noinline__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:331:10
pub const __attribute_deprecated__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:339:10
pub const __attribute_deprecated_msg__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:349:10
pub const __attribute_format_arg__ = @compileError("unable to translate macro: undefined identifier `__format_arg__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:362:10
pub const __attribute_format_strfmon__ = @compileError("unable to translate macro: undefined identifier `__format__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:372:10
pub const __attribute_nonnull__ = @compileError("unable to translate macro: undefined identifier `__nonnull__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:384:11
pub inline fn __nonnull(params: anytype) @TypeOf(__attribute_nonnull__(params)) {
    _ = &params;
    return __attribute_nonnull__(params);
}
pub const __returns_nonnull = @compileError("unable to translate macro: undefined identifier `__returns_nonnull__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:397:10
pub const __attribute_warn_unused_result__ = @compileError("unable to translate macro: undefined identifier `__warn_unused_result__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:406:10
pub const __wur = "";
pub const __always_inline = @compileError("unable to translate macro: undefined identifier `__always_inline__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:424:10
pub const __attribute_artificial__ = @compileError("unable to translate macro: undefined identifier `__artificial__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:433:10
pub const __extern_inline = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:455:11
pub const __extern_always_inline = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:456:11
pub const __fortify_function = __extern_always_inline ++ __attribute_artificial__;
pub const __va_arg_pack = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg_pack`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:467:10
pub const __va_arg_pack_len = @compileError("unable to translate macro: undefined identifier `__builtin_va_arg_pack_len`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:468:10
pub const __restrict_arr = @compileError("unable to translate C expr: unexpected token '__restrict'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:495:10
pub inline fn __glibc_unlikely(cond: anytype) @TypeOf(__builtin.expect(cond, @as(c_int, 0))) {
    _ = &cond;
    return __builtin.expect(cond, @as(c_int, 0));
}
pub inline fn __glibc_likely(cond: anytype) @TypeOf(__builtin.expect(cond, @as(c_int, 1))) {
    _ = &cond;
    return __builtin.expect(cond, @as(c_int, 1));
}
pub const __attribute_nonstring__ = "";
pub inline fn __attribute_copy__(arg: anytype) void {
    _ = &arg;
    return;
}
pub const __LDOUBLE_REDIRECTS_TO_FLOAT128_ABI = @as(c_int, 0);
pub inline fn __LDBL_REDIR1(name: anytype, proto: anytype, alias: anytype) @TypeOf(name ++ proto) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return name ++ proto;
}
pub inline fn __LDBL_REDIR(name: anytype, proto: anytype) @TypeOf(name ++ proto) {
    _ = &name;
    _ = &proto;
    return name ++ proto;
}
pub inline fn __LDBL_REDIR1_NTH(name: anytype, proto: anytype, alias: anytype) @TypeOf(name ++ proto ++ __THROW) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return name ++ proto ++ __THROW;
}
pub inline fn __LDBL_REDIR_NTH(name: anytype, proto: anytype) @TypeOf(name ++ proto ++ __THROW) {
    _ = &name;
    _ = &proto;
    return name ++ proto ++ __THROW;
}
pub inline fn __LDBL_REDIR2_DECL(name: anytype) void {
    _ = &name;
    return;
}
pub inline fn __LDBL_REDIR_DECL(name: anytype) void {
    _ = &name;
    return;
}
pub inline fn __REDIRECT_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT(name, proto, alias);
}
pub inline fn __REDIRECT_NTH_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT_NTH(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT_NTH(name, proto, alias);
}
pub const __glibc_macro_warning1 = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:635:10
pub const __glibc_macro_warning = @compileError("unable to translate macro: undefined identifier `GCC`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:636:10
pub const __HAVE_GENERIC_SELECTION = @as(c_int, 1);
pub inline fn __fortified_attr_access(a: anytype, o: anytype, s: anytype) void {
    _ = &a;
    _ = &o;
    _ = &s;
    return;
}
pub inline fn __attr_access(x: anytype) void {
    _ = &x;
    return;
}
pub inline fn __attr_access_none(argno: anytype) void {
    _ = &argno;
    return;
}
pub inline fn __attr_dealloc(dealloc: anytype, argno: anytype) void {
    _ = &dealloc;
    _ = &argno;
    return;
}
pub const __attr_dealloc_free = "";
pub const __attribute_returns_twice__ = @compileError("unable to translate macro: undefined identifier `__returns_twice__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:700:10
pub const __stub___compat_bdflush = "";
pub const __stub_chflags = "";
pub const __stub_fchflags = "";
pub const __stub_gtty = "";
pub const __stub_revoke = "";
pub const __stub_setlogin = "";
pub const __stub_sigreturn = "";
pub const __stub_stty = "";
pub const __GLIBC_USE_LIB_EXT2 = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_BFP_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_BFP_EXT_C2X = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT_C2X = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_TYPES_EXT = @as(c_int, 0);
pub const _BITS_TYPES_H = @as(c_int, 1);
pub const __S16_TYPE = c_short;
pub const __U16_TYPE = c_ushort;
pub const __S32_TYPE = c_int;
pub const __U32_TYPE = c_uint;
pub const __SLONGWORD_TYPE = c_long;
pub const __ULONGWORD_TYPE = c_ulong;
pub const __SQUAD_TYPE = c_long;
pub const __UQUAD_TYPE = c_ulong;
pub const __SWORD_TYPE = c_long;
pub const __UWORD_TYPE = c_ulong;
pub const __SLONG32_TYPE = c_int;
pub const __ULONG32_TYPE = c_uint;
pub const __S64_TYPE = c_long;
pub const __U64_TYPE = c_ulong;
pub const _BITS_TYPESIZES_H = @as(c_int, 1);
pub const __SYSCALL_SLONG_TYPE = __SLONGWORD_TYPE;
pub const __SYSCALL_ULONG_TYPE = __ULONGWORD_TYPE;
pub const __DEV_T_TYPE = __UQUAD_TYPE;
pub const __UID_T_TYPE = __U32_TYPE;
pub const __GID_T_TYPE = __U32_TYPE;
pub const __INO_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __INO64_T_TYPE = __UQUAD_TYPE;
pub const __MODE_T_TYPE = __U32_TYPE;
pub const __NLINK_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSWORD_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF64_T_TYPE = __SQUAD_TYPE;
pub const __PID_T_TYPE = __S32_TYPE;
pub const __RLIM_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __RLIM64_T_TYPE = __UQUAD_TYPE;
pub const __BLKCNT_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __BLKCNT64_T_TYPE = __SQUAD_TYPE;
pub const __FSBLKCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSBLKCNT64_T_TYPE = __UQUAD_TYPE;
pub const __FSFILCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSFILCNT64_T_TYPE = __UQUAD_TYPE;
pub const __ID_T_TYPE = __U32_TYPE;
pub const __CLOCK_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __TIME_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __USECONDS_T_TYPE = __U32_TYPE;
pub const __SUSECONDS_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __SUSECONDS64_T_TYPE = __SQUAD_TYPE;
pub const __DADDR_T_TYPE = __S32_TYPE;
pub const __KEY_T_TYPE = __S32_TYPE;
pub const __CLOCKID_T_TYPE = __S32_TYPE;
pub const __TIMER_T_TYPE = ?*anyopaque;
pub const __BLKSIZE_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __FSID_T_TYPE = @compileError("unable to translate macro: undefined identifier `__val`");
// /usr/include/x86_64-linux-gnu/bits/typesizes.h:73:9
pub const __SSIZE_T_TYPE = __SWORD_TYPE;
pub const __CPU_MASK_TYPE = __SYSCALL_ULONG_TYPE;
pub const __OFF_T_MATCHES_OFF64_T = @as(c_int, 1);
pub const __INO_T_MATCHES_INO64_T = @as(c_int, 1);
pub const __RLIM_T_MATCHES_RLIM64_T = @as(c_int, 1);
pub const __STATFS_MATCHES_STATFS64 = @as(c_int, 1);
pub const __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 = @as(c_int, 1);
pub const __FD_SETSIZE = @as(c_int, 1024);
pub const _BITS_TIME64_H = @as(c_int, 1);
pub const __TIME64_T_TYPE = __TIME_T_TYPE;
pub const _BITS_WCHAR_H = @as(c_int, 1);
pub const __WCHAR_MAX = __WCHAR_MAX__;
pub const __WCHAR_MIN = -__WCHAR_MAX - @as(c_int, 1);
pub const _BITS_STDINT_INTN_H = @as(c_int, 1);
pub const _BITS_STDINT_UINTN_H = @as(c_int, 1);
pub const __intptr_t_defined = "";
pub const INT8_MIN = -@as(c_int, 128);
pub const INT16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT32_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT8_MAX = @as(c_int, 127);
pub const INT16_MAX = @as(c_int, 32767);
pub const INT32_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT8_MAX = @as(c_int, 255);
pub const UINT16_MAX = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT32_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_LEAST8_MIN = -@as(c_int, 128);
pub const INT_LEAST16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT_LEAST32_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT_LEAST64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_LEAST8_MAX = @as(c_int, 127);
pub const INT_LEAST16_MAX = @as(c_int, 32767);
pub const INT_LEAST32_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT_LEAST64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_LEAST8_MAX = @as(c_int, 255);
pub const UINT_LEAST16_MAX = __helpers.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST32_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_FAST8_MIN = -@as(c_int, 128);
pub const INT_FAST16_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST32_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST64_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_FAST8_MAX = @as(c_int, 127);
pub const INT_FAST16_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST32_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST64_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_FAST8_MAX = @as(c_int, 255);
pub const UINT_FAST16_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST32_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INTPTR_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INTPTR_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const UINTPTR_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const INTMAX_MIN = -__INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INTMAX_MAX = __INT64_C(__helpers.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINTMAX_MAX = __UINT64_C(__helpers.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const PTRDIFF_MIN = -__helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const PTRDIFF_MAX = __helpers.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const SIG_ATOMIC_MIN = -__helpers.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const SIG_ATOMIC_MAX = __helpers.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const SIZE_MAX = __helpers.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const WCHAR_MIN = __WCHAR_MIN;
pub const WCHAR_MAX = __WCHAR_MAX;
pub const WINT_MIN = @as(c_uint, 0);
pub const WINT_MAX = __helpers.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub inline fn INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const INT64_C = __helpers.L_SUFFIX;
pub inline fn UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const UINT32_C = __helpers.U_SUFFIX;
pub const UINT64_C = __helpers.UL_SUFFIX;
pub const INTMAX_C = __helpers.L_SUFFIX;
pub const UINTMAX_C = __helpers.UL_SUFFIX;
pub const DPI_EXPORT = "";
pub const DPI_MAJOR_VERSION = @as(c_int, 26);
pub const DPI_MINOR_VERSION = @as(c_int, 0);
pub const DPI_PATCH_LEVEL = @as(c_int, 0);
pub const DPI_VERSION_SUFFIX = "";
pub const DPI_STR_HELPER = @compileError("unable to translate C expr: unexpected token ''");
// src/oracle/vendor/odpi-c/include/dpi.h:76:9
pub inline fn DPI_STR(x: anytype) @TypeOf(DPI_STR_HELPER(x)) {
    _ = &x;
    return DPI_STR_HELPER(x);
}
pub const DPI_VERSION_STRING = DPI_STR(DPI_MAJOR_VERSION) ++ "." ++ DPI_STR(DPI_MINOR_VERSION) ++ "." ++ DPI_STR(DPI_PATCH_LEVEL);
pub const DPI_DEFAULT_DRIVER_NAME = "ODPI-C : " ++ DPI_VERSION_STRING;
pub inline fn DPI_VERSION_TO_NUMBER(major: anytype, minor: anytype, patch: anytype) @TypeOf(((major * @as(c_int, 10000)) + (minor * @as(c_int, 100))) + patch) {
    _ = &major;
    _ = &minor;
    _ = &patch;
    return ((major * @as(c_int, 10000)) + (minor * @as(c_int, 100))) + patch;
}
pub const DPI_VERSION_NUMBER = DPI_VERSION_TO_NUMBER(DPI_MAJOR_VERSION, DPI_MINOR_VERSION, DPI_PATCH_LEVEL);
pub inline fn DPI_ORACLE_VERSION_TO_NUMBER(versionNum: anytype, releaseNum: anytype, updateNum: anytype, portReleaseNum: anytype, portUpdateNum: anytype) @TypeOf(((((versionNum * @as(c_ulonglong, 100000000)) + (releaseNum * @as(c_ulonglong, 1000000))) + (updateNum * @as(c_ulonglong, 10000))) + (portReleaseNum * @as(c_ulonglong, 100))) + portUpdateNum) {
    _ = &versionNum;
    _ = &releaseNum;
    _ = &updateNum;
    _ = &portReleaseNum;
    _ = &portUpdateNum;
    return ((((versionNum * @as(c_ulonglong, 100000000)) + (releaseNum * @as(c_ulonglong, 1000000))) + (updateNum * @as(c_ulonglong, 10000))) + (portReleaseNum * @as(c_ulonglong, 100))) + portUpdateNum;
}
pub const DPI_DEFAULT_FETCH_ARRAY_SIZE = @as(c_int, 100);
pub const DPI_DEFAULT_PREFETCH_ROWS = @as(c_int, 2);
pub const DPI_DEFAULT_PING_INTERVAL = @as(c_int, 60);
pub const DPI_DEFAULT_PING_TIMEOUT = @as(c_int, 5000);
pub const DPI_DEFAULT_STMT_CACHE_SIZE = @as(c_int, 20);
pub const DPI_DEQ_WAIT_NO_WAIT = @as(c_int, 0);
pub const DPI_DEQ_WAIT_FOREVER = __helpers.cast(u32, -@as(c_int, 1));
pub const DPI_MAX_INT64_PRECISION = @as(c_int, 18);
pub const DPI_SUCCESS = @as(c_int, 0);
pub const DPI_FAILURE = -@as(c_int, 1);
pub const DPI_DEBUG_LEVEL_UNREPORTED_ERRORS = @as(c_int, 0x0001);
pub const DPI_DEBUG_LEVEL_REFS = @as(c_int, 0x0002);
pub const DPI_DEBUG_LEVEL_FNS = @as(c_int, 0x0004);
pub const DPI_DEBUG_LEVEL_ERRORS = @as(c_int, 0x0008);
pub const DPI_DEBUG_LEVEL_SQL = @as(c_int, 0x0010);
pub const DPI_DEBUG_LEVEL_MEM = @as(c_int, 0x0020);
pub const DPI_DEBUG_LEVEL_LOAD_LIB = @as(c_int, 0x0040);
pub const DPI_MODE_AUTH_DEFAULT = @as(c_int, 0x00000000);
pub const DPI_MODE_AUTH_SYSDBA = @as(c_int, 0x00000002);
pub const DPI_MODE_AUTH_SYSOPER = @as(c_int, 0x00000004);
pub const DPI_MODE_AUTH_PRELIM = @as(c_int, 0x00000008);
pub const DPI_MODE_AUTH_SYSASM = __helpers.promoteIntLiteral(c_int, 0x00008000, .hex);
pub const DPI_MODE_AUTH_SYSBKP = __helpers.promoteIntLiteral(c_int, 0x00020000, .hex);
pub const DPI_MODE_AUTH_SYSDGD = __helpers.promoteIntLiteral(c_int, 0x00040000, .hex);
pub const DPI_MODE_AUTH_SYSKMT = __helpers.promoteIntLiteral(c_int, 0x00080000, .hex);
pub const DPI_MODE_AUTH_SYSRAC = __helpers.promoteIntLiteral(c_int, 0x00100000, .hex);
pub const DPI_MODE_CONN_CLOSE_DEFAULT = @as(c_int, 0x0000);
pub const DPI_MODE_CONN_CLOSE_DROP = @as(c_int, 0x0001);
pub const DPI_MODE_CONN_CLOSE_RETAG = @as(c_int, 0x0002);
pub const DPI_MODE_CREATE_DEFAULT = @as(c_int, 0x00000000);
pub const DPI_MODE_CREATE_THREADED = @as(c_int, 0x00000001);
pub const DPI_MODE_CREATE_EVENTS = @as(c_int, 0x00000004);
pub const DPI_MODE_DEQ_BROWSE = @as(c_int, 1);
pub const DPI_MODE_DEQ_LOCKED = @as(c_int, 2);
pub const DPI_MODE_DEQ_REMOVE = @as(c_int, 3);
pub const DPI_MODE_DEQ_REMOVE_NO_DATA = @as(c_int, 4);
pub const DPI_DEQ_NAV_FIRST_MSG = @as(c_int, 1);
pub const DPI_DEQ_NAV_NEXT_TRANSACTION = @as(c_int, 2);
pub const DPI_DEQ_NAV_NEXT_MSG = @as(c_int, 3);
pub const DPI_EVENT_NONE = @as(c_int, 0);
pub const DPI_EVENT_STARTUP = @as(c_int, 1);
pub const DPI_EVENT_SHUTDOWN = @as(c_int, 2);
pub const DPI_EVENT_SHUTDOWN_ANY = @as(c_int, 3);
pub const DPI_EVENT_DEREG = @as(c_int, 5);
pub const DPI_EVENT_OBJCHANGE = @as(c_int, 6);
pub const DPI_EVENT_QUERYCHANGE = @as(c_int, 7);
pub const DPI_EVENT_AQ = @as(c_int, 100);
pub const DPI_JSON_OPT_DEFAULT = @as(c_int, 0x00);
pub const DPI_JSON_OPT_NUMBER_AS_STRING = @as(c_int, 0x01);
pub const DPI_JSON_OPT_DATE_AS_DOUBLE = @as(c_int, 0x02);
pub const DPI_MODE_EXEC_DEFAULT = @as(c_int, 0x00000000);
pub const DPI_MODE_EXEC_SUSPEND_ON_SUCCESS = @as(c_int, 0x00000004);
pub const DPI_MODE_EXEC_DESCRIBE_ONLY = @as(c_int, 0x00000010);
pub const DPI_MODE_EXEC_COMMIT_ON_SUCCESS = @as(c_int, 0x00000020);
pub const DPI_MODE_EXEC_BATCH_ERRORS = @as(c_int, 0x00000080);
pub const DPI_MODE_EXEC_PARSE_ONLY = @as(c_int, 0x00000100);
pub const DPI_MODE_EXEC_ARRAY_DML_ROWCOUNTS = __helpers.promoteIntLiteral(c_int, 0x00100000, .hex);
pub const DPI_MODE_FETCH_NEXT = @as(c_int, 0x0002);
pub const DPI_MODE_FETCH_FIRST = @as(c_int, 0x0004);
pub const DPI_MODE_FETCH_LAST = @as(c_int, 0x0008);
pub const DPI_MODE_FETCH_PRIOR = @as(c_int, 0x0010);
pub const DPI_MODE_FETCH_ABSOLUTE = @as(c_int, 0x0020);
pub const DPI_MODE_FETCH_RELATIVE = @as(c_int, 0x0040);
pub const DPI_MODE_MSG_PERSISTENT = @as(c_int, 1);
pub const DPI_MODE_MSG_BUFFERED = @as(c_int, 2);
pub const DPI_MODE_MSG_PERSISTENT_OR_BUFFERED = @as(c_int, 3);
pub const DPI_MSG_STATE_READY = @as(c_int, 0);
pub const DPI_MSG_STATE_WAITING = @as(c_int, 1);
pub const DPI_MSG_STATE_PROCESSED = @as(c_int, 2);
pub const DPI_MSG_STATE_EXPIRED = @as(c_int, 3);
pub const DPI_NATIVE_TYPE_INT64 = @as(c_int, 3000);
pub const DPI_NATIVE_TYPE_UINT64 = @as(c_int, 3001);
pub const DPI_NATIVE_TYPE_FLOAT = @as(c_int, 3002);
pub const DPI_NATIVE_TYPE_DOUBLE = @as(c_int, 3003);
pub const DPI_NATIVE_TYPE_BYTES = @as(c_int, 3004);
pub const DPI_NATIVE_TYPE_TIMESTAMP = @as(c_int, 3005);
pub const DPI_NATIVE_TYPE_INTERVAL_DS = @as(c_int, 3006);
pub const DPI_NATIVE_TYPE_INTERVAL_YM = @as(c_int, 3007);
pub const DPI_NATIVE_TYPE_LOB = @as(c_int, 3008);
pub const DPI_NATIVE_TYPE_OBJECT = @as(c_int, 3009);
pub const DPI_NATIVE_TYPE_STMT = @as(c_int, 3010);
pub const DPI_NATIVE_TYPE_BOOLEAN = @as(c_int, 3011);
pub const DPI_NATIVE_TYPE_ROWID = @as(c_int, 3012);
pub const DPI_NATIVE_TYPE_JSON = @as(c_int, 3013);
pub const DPI_NATIVE_TYPE_JSON_OBJECT = @as(c_int, 3014);
pub const DPI_NATIVE_TYPE_JSON_ARRAY = @as(c_int, 3015);
pub const DPI_NATIVE_TYPE_NULL = @as(c_int, 3016);
pub const DPI_NATIVE_TYPE_VECTOR = @as(c_int, 3017);
pub const DPI_OPCODE_ALL_OPS = @as(c_int, 0x0);
pub const DPI_OPCODE_ALL_ROWS = @as(c_int, 0x1);
pub const DPI_OPCODE_INSERT = @as(c_int, 0x2);
pub const DPI_OPCODE_UPDATE = @as(c_int, 0x4);
pub const DPI_OPCODE_DELETE = @as(c_int, 0x8);
pub const DPI_OPCODE_ALTER = @as(c_int, 0x10);
pub const DPI_OPCODE_DROP = @as(c_int, 0x20);
pub const DPI_OPCODE_UNKNOWN = @as(c_int, 0x40);
pub const DPI_ORACLE_TYPE_NONE = @as(c_int, 2000);
pub const DPI_ORACLE_TYPE_VARCHAR = @as(c_int, 2001);
pub const DPI_ORACLE_TYPE_NVARCHAR = @as(c_int, 2002);
pub const DPI_ORACLE_TYPE_CHAR = @as(c_int, 2003);
pub const DPI_ORACLE_TYPE_NCHAR = @as(c_int, 2004);
pub const DPI_ORACLE_TYPE_ROWID = @as(c_int, 2005);
pub const DPI_ORACLE_TYPE_RAW = @as(c_int, 2006);
pub const DPI_ORACLE_TYPE_NATIVE_FLOAT = @as(c_int, 2007);
pub const DPI_ORACLE_TYPE_NATIVE_DOUBLE = @as(c_int, 2008);
pub const DPI_ORACLE_TYPE_NATIVE_INT = @as(c_int, 2009);
pub const DPI_ORACLE_TYPE_NUMBER = @as(c_int, 2010);
pub const DPI_ORACLE_TYPE_DATE = @as(c_int, 2011);
pub const DPI_ORACLE_TYPE_TIMESTAMP = @as(c_int, 2012);
pub const DPI_ORACLE_TYPE_TIMESTAMP_TZ = @as(c_int, 2013);
pub const DPI_ORACLE_TYPE_TIMESTAMP_LTZ = @as(c_int, 2014);
pub const DPI_ORACLE_TYPE_INTERVAL_DS = @as(c_int, 2015);
pub const DPI_ORACLE_TYPE_INTERVAL_YM = @as(c_int, 2016);
pub const DPI_ORACLE_TYPE_CLOB = @as(c_int, 2017);
pub const DPI_ORACLE_TYPE_NCLOB = @as(c_int, 2018);
pub const DPI_ORACLE_TYPE_BLOB = @as(c_int, 2019);
pub const DPI_ORACLE_TYPE_BFILE = @as(c_int, 2020);
pub const DPI_ORACLE_TYPE_STMT = @as(c_int, 2021);
pub const DPI_ORACLE_TYPE_BOOLEAN = @as(c_int, 2022);
pub const DPI_ORACLE_TYPE_OBJECT = @as(c_int, 2023);
pub const DPI_ORACLE_TYPE_LONG_VARCHAR = @as(c_int, 2024);
pub const DPI_ORACLE_TYPE_LONG_RAW = @as(c_int, 2025);
pub const DPI_ORACLE_TYPE_NATIVE_UINT = @as(c_int, 2026);
pub const DPI_ORACLE_TYPE_JSON = @as(c_int, 2027);
pub const DPI_ORACLE_TYPE_JSON_OBJECT = @as(c_int, 2028);
pub const DPI_ORACLE_TYPE_JSON_ARRAY = @as(c_int, 2029);
pub const DPI_ORACLE_TYPE_UROWID = @as(c_int, 2030);
pub const DPI_ORACLE_TYPE_LONG_NVARCHAR = @as(c_int, 2031);
pub const DPI_ORACLE_TYPE_XMLTYPE = @as(c_int, 2032);
pub const DPI_ORACLE_TYPE_VECTOR = @as(c_int, 2033);
pub const DPI_ORACLE_TYPE_JSON_ID = @as(c_int, 2034);
pub const DPI_ORACLE_TYPE_MAX = @as(c_int, 2035);
pub const DPI_MODE_POOL_CLOSE_DEFAULT = @as(c_int, 0x0000);
pub const DPI_MODE_POOL_CLOSE_FORCE = @as(c_int, 0x0001);
pub const DPI_MODE_POOL_GET_WAIT = @as(c_int, 0);
pub const DPI_MODE_POOL_GET_NOWAIT = @as(c_int, 1);
pub const DPI_MODE_POOL_GET_FORCEGET = @as(c_int, 2);
pub const DPI_MODE_POOL_GET_TIMEDWAIT = @as(c_int, 3);
pub const DPI_PURITY_DEFAULT = @as(c_int, 0);
pub const DPI_PURITY_NEW = @as(c_int, 1);
pub const DPI_PURITY_SELF = @as(c_int, 2);
pub const DPI_MODE_SHUTDOWN_DEFAULT = @as(c_int, 0);
pub const DPI_MODE_SHUTDOWN_TRANSACTIONAL = @as(c_int, 1);
pub const DPI_MODE_SHUTDOWN_TRANSACTIONAL_LOCAL = @as(c_int, 2);
pub const DPI_MODE_SHUTDOWN_IMMEDIATE = @as(c_int, 3);
pub const DPI_MODE_SHUTDOWN_ABORT = @as(c_int, 4);
pub const DPI_MODE_SHUTDOWN_FINAL = @as(c_int, 5);
pub const DPI_SODA_FLAGS_DEFAULT = @as(c_int, 0x00);
pub const DPI_SODA_FLAGS_ATOMIC_COMMIT = @as(c_int, 0x01);
pub const DPI_SODA_FLAGS_CREATE_COLL_MAP = @as(c_int, 0x02);
pub const DPI_SODA_FLAGS_INDEX_DROP_FORCE = @as(c_int, 0x04);
pub const DPI_MODE_STARTUP_DEFAULT = @as(c_int, 0);
pub const DPI_MODE_STARTUP_FORCE = @as(c_int, 1);
pub const DPI_MODE_STARTUP_RESTRICT = @as(c_int, 2);
pub const DPI_SERVER_TYPE_UNKNOWN = @as(c_int, 0);
pub const DPI_SERVER_TYPE_DEDICATED = @as(c_int, 1);
pub const DPI_SERVER_TYPE_SHARED = @as(c_int, 2);
pub const DPI_SERVER_TYPE_POOLED = @as(c_int, 4);
pub const DPI_STMT_TYPE_UNKNOWN = @as(c_int, 0);
pub const DPI_STMT_TYPE_SELECT = @as(c_int, 1);
pub const DPI_STMT_TYPE_UPDATE = @as(c_int, 2);
pub const DPI_STMT_TYPE_DELETE = @as(c_int, 3);
pub const DPI_STMT_TYPE_INSERT = @as(c_int, 4);
pub const DPI_STMT_TYPE_CREATE = @as(c_int, 5);
pub const DPI_STMT_TYPE_DROP = @as(c_int, 6);
pub const DPI_STMT_TYPE_ALTER = @as(c_int, 7);
pub const DPI_STMT_TYPE_BEGIN = @as(c_int, 8);
pub const DPI_STMT_TYPE_DECLARE = @as(c_int, 9);
pub const DPI_STMT_TYPE_CALL = @as(c_int, 10);
pub const DPI_STMT_TYPE_EXPLAIN_PLAN = @as(c_int, 15);
pub const DPI_STMT_TYPE_MERGE = @as(c_int, 16);
pub const DPI_STMT_TYPE_ROLLBACK = @as(c_int, 17);
pub const DPI_STMT_TYPE_COMMIT = @as(c_int, 21);
pub const DPI_SUBSCR_GROUPING_CLASS_TIME = @as(c_int, 1);
pub const DPI_SUBSCR_GROUPING_TYPE_SUMMARY = @as(c_int, 1);
pub const DPI_SUBSCR_GROUPING_TYPE_LAST = @as(c_int, 2);
pub const DPI_SUBSCR_NAMESPACE_AQ = @as(c_int, 1);
pub const DPI_SUBSCR_NAMESPACE_DBCHANGE = @as(c_int, 2);
pub const DPI_SUBSCR_PROTO_CALLBACK = @as(c_int, 0);
pub const DPI_SUBSCR_PROTO_MAIL = @as(c_int, 1);
pub const DPI_SUBSCR_PROTO_PLSQL = @as(c_int, 2);
pub const DPI_SUBSCR_PROTO_HTTP = @as(c_int, 3);
pub const DPI_SUBSCR_QOS_RELIABLE = @as(c_int, 0x01);
pub const DPI_SUBSCR_QOS_DEREG_NFY = @as(c_int, 0x02);
pub const DPI_SUBSCR_QOS_ROWIDS = @as(c_int, 0x04);
pub const DPI_SUBSCR_QOS_QUERY = @as(c_int, 0x08);
pub const DPI_SUBSCR_QOS_BEST_EFFORT = @as(c_int, 0x10);
pub const DPI_TPC_BEGIN_JOIN = @as(c_int, 0x00000002);
pub const DPI_TPC_BEGIN_NEW = @as(c_int, 0x00000001);
pub const DPI_TPC_BEGIN_PROMOTE = @as(c_int, 0x00000008);
pub const DPI_TPC_BEGIN_RESUME = @as(c_int, 0x00000004);
pub const DPI_TPC_END_NORMAL = @as(c_int, 0);
pub const DPI_TPC_END_SUSPEND = __helpers.promoteIntLiteral(c_int, 0x00100000, .hex);
pub const DPI_VECTOR_FLAGS_FLEXIBLE_DIM = @as(c_int, 0x01);
pub const DPI_VECTOR_FLAGS_SPARSE = @as(c_int, 0x02);
pub const DPI_VECTOR_FORMAT_FLOAT32 = @as(c_int, 2);
pub const DPI_VECTOR_FORMAT_FLOAT64 = @as(c_int, 3);
pub const DPI_VECTOR_FORMAT_INT8 = @as(c_int, 4);
pub const DPI_VECTOR_FORMAT_BINARY = @as(c_int, 5);
pub const DPI_VISIBILITY_IMMEDIATE = @as(c_int, 1);
pub const DPI_VISIBILITY_ON_COMMIT = @as(c_int, 2);
pub const dpiContext_create = @compileError("unable to translate macro: undefined identifier `NULL`");
// src/oracle/vendor/odpi-c/include/dpi.h:964:9
