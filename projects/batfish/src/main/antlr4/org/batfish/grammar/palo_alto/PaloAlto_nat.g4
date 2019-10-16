parser grammar PaloAlto_nat;

import PaloAlto_common;

options {
    tokenVocab = PaloAltoLexer;
}

sr_nat
:
    NAT sr_nat_rules?
;

sr_nat_rules
:
    RULES srn_definition?
;

srn_definition
:
    name = variable
    (
        srn_destination_translation
        | srn_source_translation
        | srn_to
        | srn_from
        | srn_source
        | srn_destination
    )?
;

srn_destination_translation
:
    DESTINATION_TRANSLATION srndt_translated_address?
;

srn_source_translation
:
    SOURCE_TRANSLATION srnst_dynamic_ip_and_port?
;

srn_from
:
    FROM variable_list?
;

srn_to
:
    TO zone = variable?
;


srn_destination
:
    DESTINATION src_or_dst_list?
;

srn_source
:
    SOURCE src_or_dst_list?
;

srnst_dynamic_ip_and_port
:
    DYNAMIC_IP_AND_PORT srnst_translated_address?
;

srndt_translated_address
:
    TRANSLATED_ADDRESS translated_address_list_item
;

srnst_translated_address
:
    TRANSLATED_ADDRESS translated_address_list
;

translated_address_list
:
    (
        translated_address_list_item
        |
        (
            OPEN_BRACKET
            (
                translated_address_list_item
            )*
            CLOSE_BRACKET
        )
    )
;

translated_address_list_item
:
    (
        address = ip_address
        | prefix = IP_PREFIX
        | range = IP_RANGE
        | name = variable
    )
;