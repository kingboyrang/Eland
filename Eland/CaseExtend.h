//
//  CaseExtend.h
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModle.h"
@interface CaseExtend : BasicModle
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *GUID;
@property(nonatomic,copy) NSString *CaseGuid;
@property(nonatomic,copy) NSString *Location;
@property(nonatomic,copy) NSString *Lng;
@property(nonatomic,copy) NSString *Lat;
@property(nonatomic,copy) NSString *Subject;
@property(nonatomic,copy) NSString *Description;
@property(nonatomic,copy) NSString *Memo;
@property(nonatomic,copy) NSString *IsAgree;
@property(nonatomic,copy) NSString *IsPublic;
@property(nonatomic,copy) NSString *IsHistory;
@property(nonatomic,copy) NSString *HistoryGuid;
@property(nonatomic,copy) NSString *Note;
@property(nonatomic,copy) NSString *Link;
@property(nonatomic,copy) NSString *LightNumber;
@property(nonatomic,copy) NSString *PetName;
@property(nonatomic,copy) NSString *PetBreed;
@property(nonatomic,copy) NSString *PetAge;
@property(nonatomic,copy) NSString *PetSterilization;
@property(nonatomic,copy) NSString *PetGender;
@property(nonatomic,copy) NSString *PetFeature;
@property(nonatomic,copy) NSString *PetChip;
@property(nonatomic,copy) NSString *PetAddress;
@property(nonatomic,copy) NSString *PetDate;
@property(nonatomic,copy) NSString *PetContact;
@property(nonatomic,copy) NSString *PetOwner;
@property(nonatomic,copy) NSString *NewbornRelation;
@property(nonatomic,copy) NSString *ManName;
@property(nonatomic,copy) NSString *WoManName;
@property(nonatomic,copy) NSString *ManAddress;
@property(nonatomic,copy) NSString *WoManAddress;
@property(nonatomic,copy) NSString *DeadRelation;
@property(nonatomic,copy) NSString *DeadName;
@property(nonatomic,copy) NSString *DeadAddress;
@property(nonatomic,copy) NSString *ImageMemo;
@property(nonatomic,copy) NSString *Note1;
@property(nonatomic,copy) NSString *Note2;
@property(nonatomic,copy) NSString *Note3;
@property(nonatomic,copy) NSString *Note4;
@property(nonatomic,copy) NSString *Note5;
@property(nonatomic,copy) NSString *Note6;
@property(nonatomic,copy) NSString *Note7;
@property(nonatomic,copy) NSString *Note8;
@property(nonatomic,copy) NSString *Note9;
@property(nonatomic,copy) NSString *Note10;
@property(nonatomic,copy) NSString *Custom1;
@property(nonatomic,copy) NSString *Custom2;
@property(nonatomic,copy) NSString *Custom3;
@property(nonatomic,copy) NSString *Custom4;
@property(nonatomic,copy) NSString *Custom5;
@property(nonatomic,copy) NSString *Custom6;
@property(nonatomic,copy) NSString *Custom7;
@property(nonatomic,copy) NSString *Custom8;
@property(nonatomic,copy) NSString *Custom9;
@property(nonatomic,copy) NSString *Custom10;

-(NSString*)XmlSerialize;
@end
