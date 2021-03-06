{-# LANGUAGE PatternSynonyms #-}

module HStream.Store.Logger
  ( Log.debug
  , Log.info
  , Log.warning
  , Log.fatal
  , Log.withDefaultLogger
  , Log.flushDefaultLogger
  , Log.setDefaultLogger
  , Log.getDefaultLogger
  , Log.Logger
  , d, i, w, e

  -- * LogDevice debug level
  , FFI.C_DBG_LEVEL
  , pattern FFI.C_DBG_CRITICAL
  , pattern FFI.C_DBG_ERROR
  , pattern FFI.C_DBG_WARNING
  , pattern FFI.C_DBG_NOTIFY
  , pattern FFI.C_DBG_INFO
  , pattern FFI.C_DBG_DEBUG
  , pattern FFI.C_DBG_SPEW

  , setLogDeviceDbgLevel
  , logDeviceDbgUseFD
  ) where

import           Foreign.C.Types              (CInt)
import qualified Z.Data.Builder               as B
import qualified Z.IO.Logger                  as Log

import qualified HStream.Store.Internal.Types as FFI

d :: B.Builder () -> IO ()
d = Log.withDefaultLogger . Log.debug

i :: B.Builder () -> IO ()
i = Log.withDefaultLogger . Log.info

w :: B.Builder () -> IO ()
w = Log.withDefaultLogger . Log.warning

e :: B.Builder () -> IO ()
e = Log.withDefaultLogger . Log.fatal

type FD = CInt

setLogDeviceDbgLevel :: FFI.C_DBG_LEVEL -> IO ()
setLogDeviceDbgLevel = FFI.c_set_dbg_level

logDeviceDbgUseFD :: FD -> IO FD
logDeviceDbgUseFD = FFI.c_dbg_use_fd
