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

ENGINE_END()
