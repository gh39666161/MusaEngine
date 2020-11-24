#include "AssetData/Public/AssetData.h"

namespace MusaEngine
{
    CAssetData::CAssetData()
    {

    }

    CAssetData::~CAssetData()
    {

    }

    int32 CAssetData::Initialize()
    {
        AddSearchPath("../../");
        return 0;
    }
    void CAssetData::Finalize()
    {

    }
    void CAssetData::Update()
    {

    }

    void CAssetData::AddSearchPath(const std::string& Path)
    {
        MSearchPaths.push_back(Path);
    }

    void* CAssetData::OpenFile(const char* Name, AssetOpenMode Mode)
    {
        FILE *FP = nullptr;
        for (auto SearchPath : MSearchPaths)
        {
            auto FullPath = SearchPath.append(Name);
            switch(Mode)
            {
                case MY_OPEN_TEXT:
                {
                    FP = fopen(FullPath.c_str(), "r");
                    break;
                }
                case MY_OPEN_BINARY:
                {
                    FP = fopen(FullPath.c_str(), "rb");
                    break;
                }
            }
        }
        return FP;
    }

    CBuffer CAssetData::SyncOpenAndReadText(const char *FilePath)
    {
        void* FP = OpenFile(FilePath, MY_OPEN_TEXT);
        CBuffer* Buffer = nullptr;

        if (FP) {
            uint64 Length = GetSize(FP);

            Buffer = new CBuffer(Length + 1);
            auto Data = Buffer->GetData();
            Length = fread(Data, 1, Length, static_cast<FILE*>(FP));
            Data[Length] = '\0';

            CloseFile(FP);
        } else {
            Buffer = new CBuffer();
        }

        return *Buffer;
    }

    std::string CAssetData::SyncOpenAndReadTextFileToString(const char* fileName)
    {
        std::string Result;
        CBuffer Buffer = SyncOpenAndReadText(fileName);
        char* Content = reinterpret_cast<char*>(Buffer.GetData());

        if (Content)
        {
            Result = std::string(std::move(Content));
        }

        return Result;
    }

    uint64 CAssetData::GetSize(void* FP)
    {
        FILE* _fp = static_cast<FILE*>(FP);

        long pos = ftell(_fp);
        fseek(_fp, 0, SEEK_END);
        size_t length = ftell(_fp);
        fseek(_fp, pos, SEEK_SET);

        return length;
    }

    void CAssetData::CloseFile(void* FP)
    {
        fclose((FILE*)FP);
        FP = nullptr;
    }
}
