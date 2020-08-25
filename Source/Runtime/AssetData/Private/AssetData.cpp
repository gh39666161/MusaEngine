#include "AssetData/Public/AssetData.h"

ENGINE_BEGIN()
FAssetData::FAssetData()
{

}

FAssetData::~FAssetData()
{

}

int32 FAssetData::Initialize()
{
    AddSearchPath("../../");
    return 0;
}
void FAssetData::Finalize()
{

}
void FAssetData::Update()
{

}

void FAssetData::AddSearchPath(const std::string& Path)
{
    MSearchPaths.push_back(Path);
}

void* FAssetData::OpenFile(const char* Name, AssetOpenMode Mode)
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

FBuffer FAssetData::SyncOpenAndReadText(const char *FilePath)
{
    void* FP = OpenFile(FilePath, MY_OPEN_TEXT);
    FBuffer* Buffer = nullptr;

    if (FP) {
        uint64 length = GetSize(FP);

        Buffer = new FBuffer(length + 1);
        auto Data = Buffer->GetData();
        length = fread(Data, 1, length, static_cast<FILE*>(FP));
        Data[length] = '\0';

        CloseFile(FP);
    } else {
        Buffer = new FBuffer();
    }

    return *Buffer;
}

std::string FAssetData::SyncOpenAndReadTextFileToString(const char* fileName)
{
    std::string result;
    FBuffer buffer = SyncOpenAndReadText(fileName);
    char* content = reinterpret_cast<char*>(buffer.GetData());

    if (content)
    {
        result = std::string(std::move(content));
    }

    return result;
}

uint64 FAssetData::GetSize(void* FP)
{
    FILE* _fp = static_cast<FILE*>(FP);

    long pos = ftell(_fp);
    fseek(_fp, 0, SEEK_END);
    size_t length = ftell(_fp);
    fseek(_fp, pos, SEEK_SET);

    return length;
}

void FAssetData::CloseFile(void* FP)
{
    fclose((FILE*)FP);
    FP = nullptr;
}

ENGINE_END()
