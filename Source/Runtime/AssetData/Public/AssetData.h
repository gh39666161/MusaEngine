#pragma once
#include <cstdio>
#include <string>
#include <utility>
#include <vector>
#include "Core/Public/RuntimeModule.hpp"
#include "Common/Public/Buffer.h"

namespace MusaEngine
{
    class CAssetData : public CRuntimeModule
    {
    public:
        enum AssetOpenMode {
            MY_OPEN_TEXT   = 0, /// Open In Text Mode
            MY_OPEN_BINARY = 1, /// Open In Binary Mode
        };

        enum AssetSeekBase {
            MY_SEEK_SET = 0, /// SEEK_SET
            MY_SEEK_CUR = 1, /// SEEK_CUR
            MY_SEEK_END = 2  /// SEEK_END
        };
        
    public:
        CAssetData();
        virtual ~CAssetData();
        virtual int32 Initialize();
        virtual void Finalize();
        virtual void Update();
        void AddSearchPath(const std::string& Path);
        void* OpenFile(const char* Name, AssetOpenMode Mode);
        CBuffer SyncOpenAndReadText(const char *FilePath);
        std::string SyncOpenAndReadTextFileToString(const char* fileName);
        uint64 GetSize(void* FP);
        void CloseFile(void* FP);
    private:
        std::vector<std::string> MSearchPaths;
    };
}
