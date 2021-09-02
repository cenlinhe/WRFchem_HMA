!**********************************************************************************  
! This computer software was prepared by Battelle Memorial Institute, hereinafter
! the Contractor, under Contract No. DE-AC05-76RL0 1830 with the Department of 
! Energy (DOE). NEITHER THE GOVERNMENT NOR THE CONTRACTOR MAKES ANY WARRANTY,
! EXPRESS OR IMPLIED, OR ASSUMES ANY LIABILITY FOR THE USE OF THIS SOFTWARE.
!
! MOSAIC module: see module_mosaic_driver.F for references and terms of use
!**********************************************************************************  
!
! WRF-chem V3.0 : Original version of optical_driver written by Jerome Fast (PNNL)
!                 and James Barnard (PNNL)
!
!WRF:MODEL_LAYER:CHEMISTRY
!
      SUBROUTINE optical_driver(id,curr_secs,dtstep,config_flags,haveaer,&
               chem,dz8w,alt,relhum,                                     &
               h2oai,h2oaj,                                              &
               tauaer1,tauaer2,tauaer3,tauaer4,                          &
               extaer1,extaer2,extaer3,extaer4,                          &
               gaer1,gaer2,gaer3,gaer4,                                  &
               waer1,waer2,waer3,waer4,                                  &
               bscoef1,bscoef2,bscoef3,bscoef4,                          &
               l2aer,l3aer,l4aer,l5aer,l6aer,l7aer,                      &
               totoa_a01,totoa_a02,totoa_a03,totoa_a04,                  &
               totoa_a05,totoa_a06,totoa_a07,totoa_a08,                  & 
               extaerlw1,extaerlw2,extaerlw3,extaerlw4,extaerlw5,extaerlw6, &
               extaerlw7,extaerlw8,extaerlw9,extaerlw10,extaerlw11,extaerlw12, &
               extaerlw13,extaerlw14,extaerlw15,extaerlw16,  &
               tauaerlw1,tauaerlw2,tauaerlw3,tauaerlw4,tauaerlw5,tauaerlw6, & 
               tauaerlw7,tauaerlw8,tauaerlw9,tauaerlw10,tauaerlw11,tauaerlw12, & 
               tauaerlw13,tauaerlw14,tauaerlw15,tauaerlw16,  &
! cenlin_DRF: add new optics variables
! for no brc case:
               tauaer1_nobrc,tauaer2_nobrc,tauaer3_nobrc,tauaer4_nobrc,  &
               extaer1_nobrc,extaer2_nobrc,extaer3_nobrc,extaer4_nobrc,  &
               gaer1_nobrc,gaer2_nobrc,gaer3_nobrc,gaer4_nobrc,          &
               waer1_nobrc,waer2_nobrc,waer3_nobrc,waer4_nobrc,          &
               bscoef1_nobrc,bscoef2_nobrc,bscoef3_nobrc,bscoef4_nobrc,  &
               l2aer_nobrc,l3aer_nobrc,l4aer_nobrc,l5aer_nobrc,l6aer_nobrc,l7aer_nobrc, &
               extaerlw1_nobrc,extaerlw2_nobrc,extaerlw3_nobrc,extaerlw4_nobrc, &
               extaerlw5_nobrc,extaerlw6_nobrc,extaerlw7_nobrc,extaerlw8_nobrc, &
               extaerlw9_nobrc,extaerlw10_nobrc,extaerlw11_nobrc,extaerlw12_nobrc, &
               extaerlw13_nobrc,extaerlw14_nobrc,extaerlw15_nobrc,extaerlw16_nobrc, &
               tauaerlw1_nobrc,tauaerlw2_nobrc,tauaerlw3_nobrc,tauaerlw4_nobrc,&
               tauaerlw5_nobrc,tauaerlw6_nobrc,tauaerlw7_nobrc,tauaerlw8_nobrc,&
               tauaerlw9_nobrc,tauaerlw10_nobrc,tauaerlw11_nobrc,tauaerlw12_nobrc,  &
               tauaerlw13_nobrc,tauaerlw14_nobrc,tauaerlw15_nobrc,tauaerlw16_nobrc, &
! for no BC case:
               tauaer1_nobc,tauaer2_nobc,tauaer3_nobc,tauaer4_nobc,  &
               extaer1_nobc,extaer2_nobc,extaer3_nobc,extaer4_nobc,  &
               gaer1_nobc,gaer2_nobc,gaer3_nobc,gaer4_nobc,          &
               waer1_nobc,waer2_nobc,waer3_nobc,waer4_nobc,          &
               bscoef1_nobc,bscoef2_nobc,bscoef3_nobc,bscoef4_nobc,  &
               l2aer_nobc,l3aer_nobc,l4aer_nobc,l5aer_nobc,l6aer_nobc,l7aer_nobc, &
               extaerlw1_nobc,extaerlw2_nobc,extaerlw3_nobc,extaerlw4_nobc, &
               extaerlw5_nobc,extaerlw6_nobc,extaerlw7_nobc,extaerlw8_nobc, &
               extaerlw9_nobc,extaerlw10_nobc,extaerlw11_nobc,extaerlw12_nobc, &
               extaerlw13_nobc,extaerlw14_nobc,extaerlw15_nobc,extaerlw16_nobc, &
               tauaerlw1_nobc,tauaerlw2_nobc,tauaerlw3_nobc,tauaerlw4_nobc,&
               tauaerlw5_nobc,tauaerlw6_nobc,tauaerlw7_nobc,tauaerlw8_nobc,&
               tauaerlw9_nobc,tauaerlw10_nobc,tauaerlw11_nobc,tauaerlw12_nobc,  &
               tauaerlw13_nobc,tauaerlw14_nobc,tauaerlw15_nobc,tauaerlw16_nobc, &
! for no dust case:
               tauaer1_nodust,tauaer2_nodust,tauaer3_nodust,tauaer4_nodust,  &
               extaer1_nodust,extaer2_nodust,extaer3_nodust,extaer4_nodust,  &
               gaer1_nodust,gaer2_nodust,gaer3_nodust,gaer4_nodust,          &
               waer1_nodust,waer2_nodust,waer3_nodust,waer4_nodust,          &
               bscoef1_nodust,bscoef2_nodust,bscoef3_nodust,bscoef4_nodust,  &
               l2aer_nodust,l3aer_nodust,l4aer_nodust,l5aer_nodust,l6aer_nodust,l7aer_nodust,&
               extaerlw1_nodust,extaerlw2_nodust,extaerlw3_nodust,extaerlw4_nodust, &
               extaerlw5_nodust,extaerlw6_nodust,extaerlw7_nodust,extaerlw8_nodust, &
               extaerlw9_nodust,extaerlw10_nodust,extaerlw11_nodust,extaerlw12_nodust, &
               extaerlw13_nodust,extaerlw14_nodust,extaerlw15_nodust,extaerlw16_nodust, &
               tauaerlw1_nodust,tauaerlw2_nodust,tauaerlw3_nodust,tauaerlw4_nodust,&
               tauaerlw5_nodust,tauaerlw6_nodust,tauaerlw7_nodust,tauaerlw8_nodust,&
               tauaerlw9_nodust,tauaerlw10_nodust,tauaerlw11_nodust,tauaerlw12_nodust,  &
               tauaerlw13_nodust,tauaerlw14_nodust,tauaerlw15_nodust,tauaerlw16_nodust, &
! cenlin_DRF end 
               ids,ide, jds,jde, kds,kde,                                &
               ims,ime, jms,jme, kms,kme,                                &
               its,ite, jts,jte, kts,kte                                 )

!------------------------------------------------------------------------
   USE module_configure
   USE module_state_description
   USE module_model_constants
   USE module_optical_averaging
   USE module_data_mosaic_therm, only: nbin_a
   USE module_data_rrtmgaeropt, only: nswbands,nlwbands 
   USE module_peg_util, only:  peg_error_fatal, peg_message
   use infnan,                 only: inf
   IMPLICIT NONE
   INTEGER,      INTENT(IN   ) :: id,                                  &
                                  ids,ide, jds,jde, kds,kde,           &
                                  ims,ime, jms,jme, kms,kme,           &
                                  its,ite, jts,jte, kts,kte
   REAL(KIND=8), INTENT(IN   ) :: curr_secs
   REAL,         INTENT(IN   ) :: dtstep
!
! array that holds all advected chemical species
!
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme, num_chem ),             &
         INTENT(IN ) ::  chem
!
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme ),                       &  
         INTENT(IN ) ::  relhum, dz8w, alt, h2oai, h2oaj,              &
                         totoa_a01, totoa_a02, totoa_a03, totoa_a04,   &
                         totoa_a05,totoa_a06,totoa_a07,totoa_a08
!
! arrays that hold the aerosol optical properties
!
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme ),                       &  
         INTENT(INOUT ) ::                                             &
           tauaer1, tauaer2, tauaer3, tauaer4,                         &
           !czhao
           extaer1, extaer2, extaer3, extaer4,                         &
           gaer1, gaer2, gaer3, gaer4,                                 &
           waer1, waer2, waer3, waer4,                                 &
           bscoef1, bscoef2, bscoef3, bscoef4                              
   !for rrtmg shortwave and longwave --czhao
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme),                &
         INTENT(INOUT ) :: extaerlw1,extaerlw2,extaerlw3,extaerlw4,extaerlw5, & 
                           extaerlw6,extaerlw7,extaerlw8,extaerlw9,extaerlw10, & 
                           extaerlw11,extaerlw12,extaerlw13,extaerlw14,extaerlw15, &
                           extaerlw16,   & 
                           tauaerlw1,tauaerlw2,tauaerlw3,tauaerlw4,tauaerlw5, &
                           tauaerlw6,tauaerlw7,tauaerlw8,tauaerlw9,tauaerlw10, & 
                           tauaerlw11,tauaerlw12,tauaerlw13,tauaerlw14,tauaerlw15, &
                           tauaerlw16

!!!! cenlin_DRF: add new variables for aerosol cases
! for no BrC case aerDRF_flag=1
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme ),INTENT(INOUT ) ::      &
         tauaer1_nobrc, tauaer2_nobrc, tauaer3_nobrc, tauaer4_nobrc,   &
         extaer1_nobrc, extaer2_nobrc, extaer3_nobrc, extaer4_nobrc,   &
         gaer1_nobrc, gaer2_nobrc, gaer3_nobrc, gaer4_nobrc,           &
         waer1_nobrc, waer2_nobrc, waer3_nobrc, waer4_nobrc,           &
         bscoef1_nobrc, bscoef2_nobrc, bscoef3_nobrc, bscoef4_nobrc
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme),INTENT(INOUT ) ::       &
     extaerlw1_nobrc,extaerlw2_nobrc,extaerlw3_nobrc,extaerlw4_nobrc,extaerlw5_nobrc, &
     extaerlw6_nobrc,extaerlw7_nobrc,extaerlw8_nobrc,extaerlw9_nobrc,extaerlw10_nobrc, &
     extaerlw11_nobrc,extaerlw12_nobrc,extaerlw13_nobrc,extaerlw14_nobrc,extaerlw15_nobrc, &
     extaerlw16_nobrc,   &
     tauaerlw1_nobrc,tauaerlw2_nobrc,tauaerlw3_nobrc,tauaerlw4_nobrc,tauaerlw5_nobrc, &
     tauaerlw6_nobrc,tauaerlw7_nobrc,tauaerlw8_nobrc,tauaerlw9_nobrc,tauaerlw10_nobrc, &
     tauaerlw11_nobrc,tauaerlw12_nobrc,tauaerlw13_nobrc,tauaerlw14_nobrc,tauaerlw15_nobrc, &
     tauaerlw16_nobrc
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme, 1:4 ),INTENT(INOUT ) :: &
     l2aer_nobrc, l3aer_nobrc, l4aer_nobrc, l5aer_nobrc, l6aer_nobrc, l7aer_nobrc

! for no BC case aerDRF_flag=2
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme ),INTENT(INOUT ) ::      &                                      
         tauaer1_nobc, tauaer2_nobc, tauaer3_nobc, tauaer4_nobc,   &
         extaer1_nobc, extaer2_nobc, extaer3_nobc, extaer4_nobc,   &
         gaer1_nobc, gaer2_nobc, gaer3_nobc, gaer4_nobc,           &
         waer1_nobc, waer2_nobc, waer3_nobc, waer4_nobc,           &
         bscoef1_nobc, bscoef2_nobc, bscoef3_nobc, bscoef4_nobc
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme),INTENT(INOUT ) ::       &
     extaerlw1_nobc,extaerlw2_nobc,extaerlw3_nobc,extaerlw4_nobc,extaerlw5_nobc, &
     extaerlw6_nobc,extaerlw7_nobc,extaerlw8_nobc,extaerlw9_nobc,extaerlw10_nobc, &
     extaerlw11_nobc,extaerlw12_nobc,extaerlw13_nobc,extaerlw14_nobc,extaerlw15_nobc, &
     extaerlw16_nobc,   &
     tauaerlw1_nobc,tauaerlw2_nobc,tauaerlw3_nobc,tauaerlw4_nobc,tauaerlw5_nobc, &
     tauaerlw6_nobc,tauaerlw7_nobc,tauaerlw8_nobc,tauaerlw9_nobc,tauaerlw10_nobc, &
     tauaerlw11_nobc,tauaerlw12_nobc,tauaerlw13_nobc,tauaerlw14_nobc,tauaerlw15_nobc, &
     tauaerlw16_nobc
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme, 1:4 ),INTENT(INOUT ) :: &
     l2aer_nobc, l3aer_nobc, l4aer_nobc, l5aer_nobc, l6aer_nobc, l7aer_nobc

! for no dust case aerDRF_flag=3
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme ),INTENT(INOUT ) ::      &                                      
         tauaer1_nodust, tauaer2_nodust, tauaer3_nodust, tauaer4_nodust,   &
         extaer1_nodust, extaer2_nodust, extaer3_nodust, extaer4_nodust,   &
         gaer1_nodust, gaer2_nodust, gaer3_nodust, gaer4_nodust,           &
         waer1_nodust, waer2_nodust, waer3_nodust, waer4_nodust,           &
         bscoef1_nodust, bscoef2_nodust, bscoef3_nodust, bscoef4_nodust
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme),INTENT(INOUT ) ::       &
     extaerlw1_nodust,extaerlw2_nodust,extaerlw3_nodust,extaerlw4_nodust,extaerlw5_nodust, &
     extaerlw6_nodust,extaerlw7_nodust,extaerlw8_nodust,extaerlw9_nodust,extaerlw10_nodust, &
     extaerlw11_nodust,extaerlw12_nodust,extaerlw13_nodust,extaerlw14_nodust,extaerlw15_nodust, &
     extaerlw16_nodust,   &
     tauaerlw1_nodust,tauaerlw2_nodust,tauaerlw3_nodust,tauaerlw4_nodust,tauaerlw5_nodust, &
     tauaerlw6_nodust,tauaerlw7_nodust,tauaerlw8_nodust,tauaerlw9_nodust,tauaerlw10_nodust, &
     tauaerlw11_nodust,tauaerlw12_nodust,tauaerlw13_nodust,tauaerlw14_nodust,tauaerlw15_nodust, &
     tauaerlw16_nodust
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme, 1:4 ),INTENT(INOUT ) :: &
     l2aer_nodust, l3aer_nodust, l4aer_nodust, l5aer_nodust, l6aer_nodust, l7aer_nodust

!!!!! cenlin_DRF end

   REAL, DIMENSION( ims:ime, kms:kme, jms:jme,1:4) ::  & 
         tauaersw,extaersw,gaersw,waersw,bscoefsw 
   REAL, DIMENSION( ims:ime, kms:kme, jms:jme, 1:4 ),                  &  
         INTENT(INOUT ) ::                                             &
           l2aer, l3aer, l4aer, l5aer, l6aer, l7aer

   REAL, DIMENSION( ims:ime, kms:kme, jms:jme,1:nlwbands) ::  &
         extaerlw,tauaerlw 

   TYPE(grid_config_rec_type),  INTENT(IN   )    :: config_flags

   character*100 msg
   integer lunerr 

   LOGICAL, INTENT(IN) :: haveaer
!         
! local variables
!
      logical processingAerosols
      integer nbin_o
      integer option_method, option_mie
      integer aerDRF_flag  ! cenlin_DRF: flag for DRF calculation of each LAP

!-----------------------------------------------------------------
! compute only if simulating aerosols and aer_ra_feedback=1

!  IF (config_flags%aer_ra_feedback .eq. 0) THEN
!        call wrf_debug(15,'no feedback, return from optical driver')
!    return
!  ENDIF
   select case (config_flags%chem_opt)
   case ( RADM2SORG,           RADM2SORG_KPP,      RADM2SORG_AQ, RADM2SORG_AQCHEM, &
          GOCART_SIMPLE,       RACMSORG_KPP,       RACMSORG_AQ,  RACMSORG_AQCHEM_KPP, &
          RACM_ESRLSORG_AQCHEM_KPP, RACM_SOA_VBS_KPP, RACM_SOA_VBS_AQCHEM_KPP,        &
          GOCARTRACM_KPP,      GOCARTRADM2,  &
          RACM_ESRLSORG_KPP,   MOZCART_KPP,                      &
          CBMZ_MOSAIC_4BIN,    CBMZ_MOSAIC_8BIN, CBMZ_MOSAIC_KPP,   &
          CBMZ_MOSAIC_4BIN_AQ, CBMZ_MOSAIC_8BIN_AQ, CBMZSORG, CBMZSORG_AQ, &
          CBMZ_MOSAIC_DMS_4BIN,    CBMZ_MOSAIC_DMS_8BIN,   &
          CBMZ_MOSAIC_DMS_4BIN_AQ, CBMZ_MOSAIC_DMS_8BIN_AQ, &    
          SAPRC99_MOSAIC_4BIN_VBS2_KPP, &
          MOZART_MOSAIC_4BIN_KPP , MOZART_MOSAIC_4BIN_AQ_KPP, &
          CBMZ_CAM_MAM3_NOAQ,CBMZ_CAM_MAM7_NOAQ,  CBMZ_CAM_MAM3_AQ,  &
          CBMZ_CAM_MAM7_AQ, CRI_MOSAIC_8BIN_AQ_KPP, CRI_MOSAIC_4BIN_AQ_KPP, &
          SAPRC99_MOSAIC_8BIN_VBS2_AQ_KPP, SAPRC99_MOSAIC_8BIN_VBS2_KPP,  &
          CB05_SORG_AQ_KPP, CB05_SORG_VBS_AQ_KPP )
      processingAerosols = .true.
      call wrf_debug(15,'optical driver: process aerosols true')
   case default
      processingAerosols = .false.
      call wrf_debug(15,'optical driver: process aerosols false')
   end select

  if( processingAerosols ) then
!
! select aerosol optical property option
! VOLUME: volume averaging of refractive indicies
! * for MADE/SORGAM, assume same 8 size bins as MOSAIC by default
! SHELL: shell-core approach, placeholder
!
   select case (config_flags%chem_opt)
   case ( RADM2SORG, RACM_ESRLSORG_KPP, RADM2SORG_KPP, RADM2SORG_AQ, RADM2SORG_AQCHEM, &
          GOCARTRACM_KPP,      GOCARTRADM2,      &
          GOCART_SIMPLE,       RACMSORG_KPP,       RACMSORG_AQ,      RACMSORG_AQCHEM_KPP, &
          RACM_ESRLSORG_AQCHEM_KPP, RACM_SOA_VBS_KPP, RACM_SOA_VBS_AQCHEM_KPP,            &
          CBMZSORG,            CBMZSORG_AQ,        MOZCART_KPP,       &
          CBMZ_CAM_MAM3_NOAQ,  CBMZ_CAM_MAM7_NOAQ,  CBMZ_CAM_MAM3_AQ,  CBMZ_CAM_MAM7_AQ, &
          CB05_SORG_AQ_KPP, CB05_SORG_VBS_AQ_KPP )
     nbin_o = 8
   case (CBMZ_MOSAIC_4BIN,    CBMZ_MOSAIC_8BIN, CBMZ_MOSAIC_KPP,  &
         CBMZ_MOSAIC_4BIN_AQ, CBMZ_MOSAIC_8BIN_AQ, &
         CBMZ_MOSAIC_DMS_4BIN,    CBMZ_MOSAIC_DMS_8BIN,   &
         CBMZ_MOSAIC_DMS_4BIN_AQ, CBMZ_MOSAIC_DMS_8BIN_AQ, &    
         SAPRC99_MOSAIC_4BIN_VBS2_KPP, &
         MOZART_MOSAIC_4BIN_KPP, MOZART_MOSAIC_4BIN_AQ_KPP, &
         CRI_MOSAIC_8BIN_AQ_KPP, CRI_MOSAIC_4BIN_AQ_KPP, &
         SAPRC99_MOSAIC_8BIN_VBS2_AQ_KPP, SAPRC99_MOSAIC_8BIN_VBS2_KPP )!BSINGH(12/05/2013): Added for SAPRC 8 bin vbs and added non-aq on 04/03/2014
     nbin_o = nbin_a
   end select
!
     call wrf_debug(15,'optical averaging')
     aer_op_opt_select: SELECT CASE(config_flags%aer_op_opt)
     CASE (VOLUME_APPROX)
       option_method=1
       option_mie=1
     CASE (MAXWELL_APPROX)
       option_method=2
       option_mie=1
     CASE (VOLUME_EXACT)
       option_method=1
       option_mie=2
     CASE (MAXWELL_EXACT)
       option_method=2
       option_mie=2
     CASE (SHELL_EXACT)
       option_method=3
       option_mie=2
     CASE DEFAULT
        if( config_flags%aer_op_opt > 0 ) then
           call wrf_message('WARNING: Invalid aer_op_opt. Defaulting to VOLUME_APPROX.')
           option_method=1
           option_mie=1
        end if
     END SELECT aer_op_opt_select

     if( config_flags%aer_op_opt > 0 ) then

! cenlin_DRF: start optical calculation for all aerosols

        call wrf_debug(15,'optical driver: call optical averaging')
!        lunerr=-1
!        write( msg, '(a, 6i4)' )	&
!                 'jdf ', ids, ide, jds, jde, kds, kde
!                 call peg_message( lunerr, msg )
!        write( msg, '(a, 6i4)' )	&
!                 'jdf ', ims, ime, jms, jme, kms, kme
!                 call peg_message( lunerr, msg )
!        write( msg, '(a, 6i4)' )	&
!                 'jdf ', its, ite, jts, jte, kts, kte
!                 call peg_message( lunerr, msg )


! cenlin_DRF: default aerDRF_flag=0 to account for all aerosol species
        aerDRF_flag = 0 ! include all aerosols

        !BSINGH(PNNL)- The followingvariables had an undefined behavior at the boundaries.
        tauaersw(:,:,:,:) = inf 
        extaersw(:,:,:,:) = inf
        gaersw(:,:,:,:)   = inf
        waersw(:,:,:,:)   = inf
        bscoefsw(:,:,:,:) = inf
        !long wave
        extaerlw(:,:,:,:) = inf
        tauaerlw(:,:,:,:) = inf

        call optical_averaging(id,curr_secs,dtstep,config_flags,     &
             nbin_o,haveaer,option_method,option_mie,chem,dz8w,alt,  &
             relhum,h2oai,h2oaj,                                     &
!czhao       tauaer1,tauaer2,tauaer3,tauaer4,                        &
!            gaer1,gaer2,gaer3,gaer4,                                &
!            waer1,waer2,waer3,waer4,                                &
!            bscoef1,bscoef2,bscoef3,bscoef4,                        &
             tauaersw,extaersw,gaersw,waersw,bscoefsw,               &
             l2aer,l3aer,l4aer,l5aer,l6aer,l7aer,                    &
             totoa_a01,totoa_a02,totoa_a03,totoa_a04,                &
             totoa_a05,totoa_a06,totoa_a07,totoa_a08,                &
             tauaerlw,extaerlw,aerDRF_flag,                          &  ! cenlin_DRF: add flag for each aerosol species DRF
             ids,ide, jds,jde, kds,kde,                              &
             ims,ime, jms,jme, kms,kme,                              &
             its,ite, jts,jte, kts,kte                               )

             !short wave
             tauaer1=tauaersw(:,:,:,1)
             tauaer2=tauaersw(:,:,:,2)
             tauaer3=tauaersw(:,:,:,3)
             tauaer4=tauaersw(:,:,:,4)
             extaer1=extaersw(:,:,:,1)
             extaer2=extaersw(:,:,:,2)
             extaer3=extaersw(:,:,:,3)
             extaer4=extaersw(:,:,:,4)
             gaer1=gaersw(:,:,:,1)
             gaer2=gaersw(:,:,:,2)
             gaer3=gaersw(:,:,:,3)
             gaer4=gaersw(:,:,:,4)
             waer1=waersw(:,:,:,1)
             waer2=waersw(:,:,:,2)
             waer3=waersw(:,:,:,3)
             waer4=waersw(:,:,:,4)
             bscoef1=bscoefsw(:,:,:,1)
             bscoef2=bscoefsw(:,:,:,2)
             bscoef3=bscoefsw(:,:,:,3)
             bscoef4=bscoefsw(:,:,:,4)
             !long wave
             extaerlw1=extaerlw(:,:,:,1)
             extaerlw2=extaerlw(:,:,:,2)
             extaerlw3=extaerlw(:,:,:,3)
             extaerlw4=extaerlw(:,:,:,4)
             extaerlw5=extaerlw(:,:,:,5)
             extaerlw6=extaerlw(:,:,:,6)
             extaerlw7=extaerlw(:,:,:,7)
             extaerlw8=extaerlw(:,:,:,8)
             extaerlw9=extaerlw(:,:,:,9)
             extaerlw10=extaerlw(:,:,:,10)
             extaerlw11=extaerlw(:,:,:,11)
             extaerlw12=extaerlw(:,:,:,12)
             extaerlw13=extaerlw(:,:,:,13)
             extaerlw14=extaerlw(:,:,:,14)
             extaerlw15=extaerlw(:,:,:,15)
             extaerlw16=extaerlw(:,:,:,16)
             tauaerlw1=tauaerlw(:,:,:,1)
             tauaerlw2=tauaerlw(:,:,:,2)
             tauaerlw3=tauaerlw(:,:,:,3)
             tauaerlw4=tauaerlw(:,:,:,4)
             tauaerlw5=tauaerlw(:,:,:,5)
             tauaerlw6=tauaerlw(:,:,:,6)
             tauaerlw7=tauaerlw(:,:,:,7)
             tauaerlw8=tauaerlw(:,:,:,8)
             tauaerlw9=tauaerlw(:,:,:,9)
             tauaerlw10=tauaerlw(:,:,:,10)
             tauaerlw11=tauaerlw(:,:,:,11)
             tauaerlw12=tauaerlw(:,:,:,12)
             tauaerlw13=tauaerlw(:,:,:,13)
             tauaerlw14=tauaerlw(:,:,:,14)
             tauaerlw15=tauaerlw(:,:,:,15)
             tauaerlw16=tauaerlw(:,:,:,16)
        call wrf_debug(15,'optical driver: after call optical averaging')


! cenlin_DRF: start optical calculation for aerosols without BrC

        call wrf_debug(15,'optical driver: call optical averaging for no BrC')
!        lunerr=-1
!        write( msg, '(a, 6i4)' )       &
!                 'jdf ', ids, ide, jds, jde, kds, kde
!                 call peg_message( lunerr, msg )
!        write( msg, '(a, 6i4)' )       &
!                 'jdf ', ims, ime, jms, jme, kms, kme
!                 call peg_message( lunerr, msg )
!        write( msg, '(a, 6i4)' )       &
!                 'jdf ', its, ite, jts, jte, kts, kte
!                 call peg_message( lunerr, msg )


! cenlin_DRF: aerDRF_flag=1 to account for no BrC case
        aerDRF_flag = 1 ! without BrC

        !BSINGH(PNNL)- The followingvariables had an undefined behavior at the boundaries.
        tauaersw(:,:,:,:) = inf
        extaersw(:,:,:,:) = inf
        gaersw(:,:,:,:)   = inf
        waersw(:,:,:,:)   = inf
        bscoefsw(:,:,:,:) = inf
        !long wave
        extaerlw(:,:,:,:) = inf
        tauaerlw(:,:,:,:) = inf

        call optical_averaging(id,curr_secs,dtstep,config_flags,     &
             nbin_o,haveaer,option_method,option_mie,chem,dz8w,alt,  &
             relhum,h2oai,h2oaj,                                     &
!czhao       tauaer1,tauaer2,tauaer3,tauaer4,                        &
!            gaer1,gaer2,gaer3,gaer4,                                &
!            waer1,waer2,waer3,waer4,                                &
!            bscoef1,bscoef2,bscoef3,bscoef4,                        &
             tauaersw,extaersw,gaersw,waersw,bscoefsw,               &
         l2aer_nobrc,l3aer_nobrc,l4aer_nobrc,l5aer_nobrc,l6aer_nobrc,l7aer_nobrc,&
             totoa_a01,totoa_a02,totoa_a03,totoa_a04,                &
             totoa_a05,totoa_a06,totoa_a07,totoa_a08,                &
             tauaerlw,extaerlw,aerDRF_flag,                          &  ! cenlin_DRF: add flag for each aerosol species DRF
             ids,ide, jds,jde, kds,kde,                              &
             ims,ime, jms,jme, kms,kme,                              &
             its,ite, jts,jte, kts,kte                               )

             !short wave
             tauaer1_nobrc=tauaersw(:,:,:,1)
             tauaer2_nobrc=tauaersw(:,:,:,2)
             tauaer3_nobrc=tauaersw(:,:,:,3)
             tauaer4_nobrc=tauaersw(:,:,:,4)
             extaer1_nobrc=extaersw(:,:,:,1)
             extaer2_nobrc=extaersw(:,:,:,2)
             extaer3_nobrc=extaersw(:,:,:,3)
             extaer4_nobrc=extaersw(:,:,:,4)
             gaer1_nobrc=gaersw(:,:,:,1)
             gaer2_nobrc=gaersw(:,:,:,2)
             gaer3_nobrc=gaersw(:,:,:,3)
             gaer4_nobrc=gaersw(:,:,:,4)
             waer1_nobrc=waersw(:,:,:,1)
             waer2_nobrc=waersw(:,:,:,2)
             waer3_nobrc=waersw(:,:,:,3)
             waer4_nobrc=waersw(:,:,:,4)
             bscoef1_nobrc=bscoefsw(:,:,:,1)
             bscoef2_nobrc=bscoefsw(:,:,:,2)
             bscoef3_nobrc=bscoefsw(:,:,:,3)
             bscoef4_nobrc=bscoefsw(:,:,:,4)
             !long wave
             extaerlw1_nobrc=extaerlw(:,:,:,1)
             extaerlw2_nobrc=extaerlw(:,:,:,2)
             extaerlw3_nobrc=extaerlw(:,:,:,3)
             extaerlw4_nobrc=extaerlw(:,:,:,4)
             extaerlw5_nobrc=extaerlw(:,:,:,5)
             extaerlw6_nobrc=extaerlw(:,:,:,6)
             extaerlw7_nobrc=extaerlw(:,:,:,7)
             extaerlw8_nobrc=extaerlw(:,:,:,8)
             extaerlw9_nobrc=extaerlw(:,:,:,9)
             extaerlw10_nobrc=extaerlw(:,:,:,10)
             extaerlw11_nobrc=extaerlw(:,:,:,11)
             extaerlw12_nobrc=extaerlw(:,:,:,12)
             extaerlw13_nobrc=extaerlw(:,:,:,13)
             extaerlw14_nobrc=extaerlw(:,:,:,14)
             extaerlw15_nobrc=extaerlw(:,:,:,15)
             extaerlw16_nobrc=extaerlw(:,:,:,16)
             tauaerlw1_nobrc=tauaerlw(:,:,:,1)
             tauaerlw2_nobrc=tauaerlw(:,:,:,2)
             tauaerlw3_nobrc=tauaerlw(:,:,:,3)
             tauaerlw4_nobrc=tauaerlw(:,:,:,4)
             tauaerlw5_nobrc=tauaerlw(:,:,:,5)
             tauaerlw6_nobrc=tauaerlw(:,:,:,6)
             tauaerlw7_nobrc=tauaerlw(:,:,:,7)
             tauaerlw8_nobrc=tauaerlw(:,:,:,8)
             tauaerlw9_nobrc=tauaerlw(:,:,:,9)
             tauaerlw10_nobrc=tauaerlw(:,:,:,10)
             tauaerlw11_nobrc=tauaerlw(:,:,:,11)
             tauaerlw12_nobrc=tauaerlw(:,:,:,12)
             tauaerlw13_nobrc=tauaerlw(:,:,:,13)
             tauaerlw14_nobrc=tauaerlw(:,:,:,14)
             tauaerlw15_nobrc=tauaerlw(:,:,:,15)
             tauaerlw16_nobrc=tauaerlw(:,:,:,16)
        call wrf_debug(15,'optical driver: after call optical averaging for no brc')

! cenlin_DRF: start optical calculation for aerosols without BC
        call wrf_debug(15,'optical driver: call optical averaging for no BC')
!        lunerr=-1
!        write( msg, '(a, 6i4)' )       &
!                 'jdf ', ids, ide, jds, jde, kds, kde
!                 call peg_message( lunerr, msg )
!        write( msg, '(a, 6i4)' )       &
!                 'jdf ', ims, ime, jms, jme, kms, kme
!                 call peg_message( lunerr, msg )
!        write( msg, '(a, 6i4)' )       &
!                 'jdf ', its, ite, jts, jte, kts, kte
!                 call peg_message( lunerr, msg )


! cenlin_DRF: aerDRF_flag=2 to account for no BC case
        aerDRF_flag = 2 ! without BC

        !BSINGH(PNNL)- The followingvariables had an undefined behavior at the boundaries.
        tauaersw(:,:,:,:) = inf
        extaersw(:,:,:,:) = inf
        gaersw(:,:,:,:)   = inf
        waersw(:,:,:,:)   = inf
        bscoefsw(:,:,:,:) = inf
        !long wave
        extaerlw(:,:,:,:) = inf
        tauaerlw(:,:,:,:) = inf

        call optical_averaging(id,curr_secs,dtstep,config_flags,     &
             nbin_o,haveaer,option_method,option_mie,chem,dz8w,alt,  &
             relhum,h2oai,h2oaj,                                     &
!czhao       tauaer1,tauaer2,tauaer3,tauaer4,                        &
!            gaer1,gaer2,gaer3,gaer4,                                &
!            waer1,waer2,waer3,waer4,                                &
!            bscoef1,bscoef2,bscoef3,bscoef4,                        &
             tauaersw,extaersw,gaersw,waersw,bscoefsw,               &
         l2aer_nobc,l3aer_nobc,l4aer_nobc,l5aer_nobc,l6aer_nobc,l7aer_nobc, &
             totoa_a01,totoa_a02,totoa_a03,totoa_a04,                &
             totoa_a05,totoa_a06,totoa_a07,totoa_a08,                &
             tauaerlw,extaerlw,aerDRF_flag,                          &  ! cenlin_DRF: add flag for each aerosol species DRF
             ids,ide, jds,jde, kds,kde,                              &
             ims,ime, jms,jme, kms,kme,                              &
             its,ite, jts,jte, kts,kte                               )

             !short wave
             tauaer1_nobc=tauaersw(:,:,:,1)
             tauaer2_nobc=tauaersw(:,:,:,2)
             tauaer3_nobc=tauaersw(:,:,:,3)
             tauaer4_nobc=tauaersw(:,:,:,4)
             extaer1_nobc=extaersw(:,:,:,1)
             extaer2_nobc=extaersw(:,:,:,2)
             extaer3_nobc=extaersw(:,:,:,3)
             extaer4_nobc=extaersw(:,:,:,4)
             gaer1_nobc=gaersw(:,:,:,1)
             gaer2_nobc=gaersw(:,:,:,2)
             gaer3_nobc=gaersw(:,:,:,3)
             gaer4_nobc=gaersw(:,:,:,4)
             waer1_nobc=waersw(:,:,:,1)
             waer2_nobc=waersw(:,:,:,2)
             waer3_nobc=waersw(:,:,:,3)
             waer4_nobc=waersw(:,:,:,4)
             bscoef1_nobc=bscoefsw(:,:,:,1)
             bscoef2_nobc=bscoefsw(:,:,:,2)
             bscoef3_nobc=bscoefsw(:,:,:,3)
             bscoef4_nobc=bscoefsw(:,:,:,4)
             !long wave
             extaerlw1_nobc=extaerlw(:,:,:,1)
             extaerlw2_nobc=extaerlw(:,:,:,2)
             extaerlw3_nobc=extaerlw(:,:,:,3)
             extaerlw4_nobc=extaerlw(:,:,:,4)
             extaerlw5_nobc=extaerlw(:,:,:,5)
             extaerlw6_nobc=extaerlw(:,:,:,6)
             extaerlw7_nobc=extaerlw(:,:,:,7)
             extaerlw8_nobc=extaerlw(:,:,:,8)
             extaerlw9_nobc=extaerlw(:,:,:,9)
             extaerlw10_nobc=extaerlw(:,:,:,10)
             extaerlw11_nobc=extaerlw(:,:,:,11)
             extaerlw12_nobc=extaerlw(:,:,:,12)
             extaerlw13_nobc=extaerlw(:,:,:,13)
             extaerlw14_nobc=extaerlw(:,:,:,14)
             extaerlw15_nobc=extaerlw(:,:,:,15)
             extaerlw16_nobc=extaerlw(:,:,:,16)
             tauaerlw1_nobc=tauaerlw(:,:,:,1)
             tauaerlw2_nobc=tauaerlw(:,:,:,2)
             tauaerlw3_nobc=tauaerlw(:,:,:,3)
             tauaerlw4_nobc=tauaerlw(:,:,:,4)
             tauaerlw5_nobc=tauaerlw(:,:,:,5)
             tauaerlw6_nobc=tauaerlw(:,:,:,6)
             tauaerlw7_nobc=tauaerlw(:,:,:,7)
             tauaerlw8_nobc=tauaerlw(:,:,:,8)
             tauaerlw9_nobc=tauaerlw(:,:,:,9)
             tauaerlw10_nobc=tauaerlw(:,:,:,10)
             tauaerlw11_nobc=tauaerlw(:,:,:,11)
             tauaerlw12_nobc=tauaerlw(:,:,:,12)
             tauaerlw13_nobc=tauaerlw(:,:,:,13)
             tauaerlw14_nobc=tauaerlw(:,:,:,14)
             tauaerlw15_nobc=tauaerlw(:,:,:,15)
             tauaerlw16_nobc=tauaerlw(:,:,:,16)
        call wrf_debug(15,'optical driver: after call optical averaging for no BC')

! cenlin_DRF: start optical calculation for aerosols without dust
        call wrf_debug(15,'optical driver: call optical averaging for no dust')
!        lunerr=-1
!        write( msg, '(a, 6i4)' )       &
!                 'jdf ', ids, ide, jds, jde, kds, kde
!                 call peg_message( lunerr, msg )
!        write( msg, '(a, 6i4)' )       &
!                 'jdf ', ims, ime, jms, jme, kms, kme
!                 call peg_message( lunerr, msg )
!        write( msg, '(a, 6i4)' )       &
!                 'jdf ', its, ite, jts, jte, kts, kte
!                 call peg_message( lunerr, msg )


! cenlin_DRF: default aerDRF_flag=3 to account for no dust case
        aerDRF_flag = 3 ! without dust

        !BSINGH(PNNL)- The followingvariables had an undefined behavior at the boundaries.
        tauaersw(:,:,:,:) = inf
        extaersw(:,:,:,:) = inf
        gaersw(:,:,:,:)   = inf
        waersw(:,:,:,:)   = inf
        bscoefsw(:,:,:,:) = inf
        !long wave
        extaerlw(:,:,:,:) = inf
        tauaerlw(:,:,:,:) = inf

        call optical_averaging(id,curr_secs,dtstep,config_flags,     &
             nbin_o,haveaer,option_method,option_mie,chem,dz8w,alt,  &
             relhum,h2oai,h2oaj,                                     &
!czhao       tauaer1,tauaer2,tauaer3,tauaer4,                        &
!            gaer1,gaer2,gaer3,gaer4,                                &
!            waer1,waer2,waer3,waer4,                                &
!            bscoef1,bscoef2,bscoef3,bscoef4,                        &
             tauaersw,extaersw,gaersw,waersw,bscoefsw,               &
        l2aer_nodust,l3aer_nodust,l4aer_nodust,l5aer_nodust,l6aer_nodust,l7aer_nodust,&
             totoa_a01,totoa_a02,totoa_a03,totoa_a04,                &
             totoa_a05,totoa_a06,totoa_a07,totoa_a08,                &
             tauaerlw,extaerlw,aerDRF_flag,                          &  ! cenlin_DRF: add flag for each aerosol species DRF
             ids,ide, jds,jde, kds,kde,                              &
             ims,ime, jms,jme, kms,kme,                              &
             its,ite, jts,jte, kts,kte                               )

             !short wave
             tauaer1_nodust=tauaersw(:,:,:,1)
             tauaer2_nodust=tauaersw(:,:,:,2)
             tauaer3_nodust=tauaersw(:,:,:,3)
             tauaer4_nodust=tauaersw(:,:,:,4)
             extaer1_nodust=extaersw(:,:,:,1)
             extaer2_nodust=extaersw(:,:,:,2)
             extaer3_nodust=extaersw(:,:,:,3)
             extaer4_nodust=extaersw(:,:,:,4)
             gaer1_nodust=gaersw(:,:,:,1)
             gaer2_nodust=gaersw(:,:,:,2)
             gaer3_nodust=gaersw(:,:,:,3)
             gaer4_nodust=gaersw(:,:,:,4)
             waer1_nodust=waersw(:,:,:,1)
             waer2_nodust=waersw(:,:,:,2)
             waer3_nodust=waersw(:,:,:,3)
             waer4_nodust=waersw(:,:,:,4)
             bscoef1_nodust=bscoefsw(:,:,:,1)
             bscoef2_nodust=bscoefsw(:,:,:,2)
             bscoef3_nodust=bscoefsw(:,:,:,3)
             bscoef4_nodust=bscoefsw(:,:,:,4)
             !long wave
             extaerlw1_nodust=extaerlw(:,:,:,1)
             extaerlw2_nodust=extaerlw(:,:,:,2)
             extaerlw3_nodust=extaerlw(:,:,:,3)
             extaerlw4_nodust=extaerlw(:,:,:,4)
             extaerlw5_nodust=extaerlw(:,:,:,5)
             extaerlw6_nodust=extaerlw(:,:,:,6)
             extaerlw7_nodust=extaerlw(:,:,:,7)
             extaerlw8_nodust=extaerlw(:,:,:,8)
             extaerlw9_nodust=extaerlw(:,:,:,9)
             extaerlw10_nodust=extaerlw(:,:,:,10)
             extaerlw11_nodust=extaerlw(:,:,:,11)
             extaerlw12_nodust=extaerlw(:,:,:,12)
             extaerlw13_nodust=extaerlw(:,:,:,13)
             extaerlw14_nodust=extaerlw(:,:,:,14)
             extaerlw15_nodust=extaerlw(:,:,:,15)
             extaerlw16_nodust=extaerlw(:,:,:,16)
             tauaerlw1_nodust=tauaerlw(:,:,:,1)
             tauaerlw2_nodust=tauaerlw(:,:,:,2)
             tauaerlw3_nodust=tauaerlw(:,:,:,3)
             tauaerlw4_nodust=tauaerlw(:,:,:,4)
             tauaerlw5_nodust=tauaerlw(:,:,:,5)
             tauaerlw6_nodust=tauaerlw(:,:,:,6)
             tauaerlw7_nodust=tauaerlw(:,:,:,7)
             tauaerlw8_nodust=tauaerlw(:,:,:,8)
             tauaerlw9_nodust=tauaerlw(:,:,:,9)
             tauaerlw10_nodust=tauaerlw(:,:,:,10)
             tauaerlw11_nodust=tauaerlw(:,:,:,11)
             tauaerlw12_nodust=tauaerlw(:,:,:,12)
             tauaerlw13_nodust=tauaerlw(:,:,:,13)
             tauaerlw14_nodust=tauaerlw(:,:,:,14)
             tauaerlw15_nodust=tauaerlw(:,:,:,15)
             tauaerlw16_nodust=tauaerlw(:,:,:,16)
        call wrf_debug(15,'optical driver: after call optical averaging for no dust')

! cenlin_DRF: end

     else
        !If aer_op_opt==0 then the optical arrays are already set to
        !zero in chemics_init so there will not be a problem if the
        !user has selected aer_ra_feedback=1.
     end if
!
   endif
   return

END SUBROUTINE optical_driver
