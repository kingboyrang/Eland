//
//  CaseExtend.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseExtend.h"

@implementation CaseExtend
-(NSString*)XmlSerialize{
    NSMutableString *xml=[NSMutableString stringWithFormat:@"<Extend>"];
    [xml appendFormat:@"<Location>%@</Location>",[self getPropertyValue:_Location]];
    [xml appendFormat:@"<Lng>%@</Lng>",[self getPropertyValue:_Lng]];
    [xml appendFormat:@"<Lat>%@</Lat>",[self getPropertyValue:_Lat]];
    [xml appendFormat:@"<Subject>%@</Subject>",[self getPropertyValue:_Subject]];
    [xml appendFormat:@"<Description>%@</Description>",[self getPropertyValue:_Description]];
    [xml appendFormat:@"<Memo>%@</Memo>",[self getPropertyValue:_Memo]];
    [xml appendFormat:@"<IsAgree>%@</IsAgree>",[self getPropertyValue:_IsAgree]];
    [xml appendFormat:@"<IsPublic>%@</IsPublic>",[self getPropertyValue:_IsPublic]];
    [xml appendFormat:@"<IsHistory>%@</IsHistory>",[self getPropertyValue:_IsHistory]];
    [xml appendFormat:@"<HistoryGuid>%@</HistoryGuid>",[self getPropertyValue:_HistoryGuid]];
    [xml appendFormat:@"<Note>%@</Note>",[self getPropertyValue:_Note]];
    [xml appendFormat:@"<Link>%@</Link>",[self getPropertyValue:_Link]];
    [xml appendFormat:@"<LightNumber>%@</LightNumber>",[self getPropertyValue:_LightNumber]];
    [xml appendFormat:@"<PetName>%@</PetName>",[self getPropertyValue:_PetName]];
    [xml appendFormat:@"<PetBreed>%@</PetBreed>",[self getPropertyValue:_PetBreed]];
    [xml appendFormat:@"<PetAge>%@</PetAge>",[self getPropertyValue:_PetAge]];
    [xml appendFormat:@"<PetSterilization>%@</PetSterilization>",[self getPropertyValue:_PetSterilization]];
    [xml appendFormat:@"<PetGender>%@</PetGender>",[self getPropertyValue:_PetGender]];
    [xml appendFormat:@"<PetFeature>%@</PetFeature>",[self getPropertyValue:_PetFeature]];
    [xml appendFormat:@"<PetChip>%@</PetChip>",[self getPropertyValue:_PetChip]];
    [xml appendFormat:@"<PetAddress>%@</PetAddress>",[self getPropertyValue:_PetAddress]];
    [xml appendFormat:@"<PetDate>%@</PetDate>",[self getPropertyValue:_PetDate]];
    [xml appendFormat:@"<PetContact>%@</PetContact>",[self getPropertyValue:_PetContact]];
    [xml appendFormat:@"<PetOwner>%@</PetOwner>",[self getPropertyValue:_PetOwner]];
    [xml appendFormat:@"<NewbornRelation>%@</NewbornRelation>",[self getPropertyValue:_NewbornRelation]];
    [xml appendFormat:@"<ManName>%@</ManName>",[self getPropertyValue:_ManName]];
    [xml appendFormat:@"<WoManName>%@</WoManName>",[self getPropertyValue:_WoManName]];
    [xml appendFormat:@"<ManAddress>%@</ManAddress>",[self getPropertyValue:_ManAddress]];
    [xml appendFormat:@"<WoManAddress>%@</WoManAddress>",[self getPropertyValue:_WoManAddress]];
    [xml appendFormat:@"<DeadRelation>%@</DeadRelation>",[self getPropertyValue:_DeadRelation]];
    [xml appendFormat:@"<DeadName>%@</DeadName>",[self getPropertyValue:_DeadName]];
    [xml appendFormat:@"<DeadAddress>%@</DeadAddress>",[self getPropertyValue:_DeadAddress]];
    [xml appendFormat:@"<ImageMemo>%@</ImageMemo>",[self getPropertyValue:_ImageMemo]];
    
    [xml appendFormat:@"<Note1>%@</Note1>",[self getPropertyValue:_Note1]];
    [xml appendFormat:@"<Note2>%@</Note2>",[self getPropertyValue:_Note2]];
    [xml appendFormat:@"<Note3>%@</Note3>",[self getPropertyValue:_Note3]];
    [xml appendFormat:@"<Note4>%@</Note4>",[self getPropertyValue:_Note4]];
    [xml appendFormat:@"<Note5>%@</Note5>",[self getPropertyValue:_Note5]];
    [xml appendFormat:@"<Note6>%@</Note6>",[self getPropertyValue:_Note6]];
    [xml appendFormat:@"<Note7>%@</Note7>",[self getPropertyValue:_Note7]];
    [xml appendFormat:@"<Note8>%@</Note8>",[self getPropertyValue:_Note8]];
    [xml appendFormat:@"<Note9>%@</Note9>",[self getPropertyValue:_Note9]];
    [xml appendFormat:@"<Note10>%@</Note10>",[self getPropertyValue:_Note10]];
    
    [xml appendFormat:@"<Custom1>%@</Custom1>",[self getPropertyValue:_Custom1]];
    [xml appendFormat:@"<Custom2>%@</Custom2>",[self getPropertyValue:_Custom2]];
    [xml appendFormat:@"<Custom3>%@</Custom3>",[self getPropertyValue:_Custom3]];
    [xml appendFormat:@"<Custom4>%@</Custom4>",[self getPropertyValue:_Custom4]];
    [xml appendFormat:@"<Custom5>%@</Custom5>",[self getPropertyValue:_Custom5]];
    [xml appendFormat:@"<Custom6>%@</Custom6>",[self getPropertyValue:_Custom6]];
    [xml appendFormat:@"<Custom7>%@</Custom7>",[self getPropertyValue:_Custom7]];
    [xml appendFormat:@"<Custom8>%@</Custom8>",[self getPropertyValue:_Custom8]];
    [xml appendFormat:@"<Custom9>%@</Custom9>",[self getPropertyValue:_Custom9]];
    [xml appendFormat:@"<Custom10>%@</Custom10>",[self getPropertyValue:_Custom10]];

    
    [xml appendString:@"</Extend>"];
    return xml;
}
@end
