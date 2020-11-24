#include "Asset/Public/Asset.h"

namespace MusaEngine
{
    CAsset::CAsset()
    {

    }

    CAsset::~CAsset()
    {

    }

    int32 CAsset::Initialize()
    {
        AddSearchPath("../../");
        return 0;
    }
    void CAsset::Finalize()
    {

    }
    void CAsset::Update()
    {

    }

    void CAsset::AddSearchPath(const std::string& Path)
    {
        MSearchPaths.push_back(Path);
    }

    void* CAsset::OpenFile(const char* Name, AssetOpenMode Mode)
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

    CBuffer CAsset::SyncOpenAndReadText(const char *FilePath)
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

    std::string CAsset::SyncOpenAndReadTextFileToString(const char* fileName)
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

    uint64 CAsset::GetSize(void* FP)
    {
        FILE* _fp = static_cast<FILE*>(FP);

        long pos = ftell(_fp);
        fseek(_fp, 0, SEEK_END);
        size_t length = ftell(_fp);
        fseek(_fp, pos, SEEK_SET);

        return length;
    }

    void CAsset::CloseFile(void* FP)
    {
        fclose((FILE*)FP);
        FP = nullptr;
    }
}
