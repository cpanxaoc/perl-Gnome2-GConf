/*
 * Copyright (c) 2003, 2004 by Emmanuele Bassi (see the file AUTHORS)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the 
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330, 
 * Boston, MA  02111-1307  USA.
 */

#include "gconfperl.h"

/* error codes taken from gconf-error.h */
static const GEnumValue _gconfperl_gconf_error_values[] = {
  { GCONF_ERROR_SUCCESS, "GCONF_ERROR_SUCCESS", "success" },
  { GCONF_ERROR_FAILED, "GCONF_ERROR_FAILED", "failed" },
  { GCONF_ERROR_NO_SERVER, "GCONF_ERROR_NO_SERVER", "no-server" },
  { GCONF_ERROR_NO_PERMISSION, "GCONF_ERROR_NO_PERMISSION", "no-permission" },
  { GCONF_ERROR_BAD_ADDRESS, "GCONF_ERROR_BAD_ADDRESS", "bad-address" },
  { GCONF_ERROR_BAD_KEY, "GCONF_ERROR_BAD_KEY", "bad-key" },
  { GCONF_ERROR_PARSE_ERROR, "GCONF_ERROR_PARSE_ERROR", "parse-error" },
  { GCONF_ERROR_CORRUPT, "GCONF_ERROR_CORRUPT", "corrupt" },
  { GCONF_ERROR_TYPE_MISMATCH, "GCONF_ERROR_TYPE_MISMATCH", "type-mismatch" },
  { GCONF_ERROR_IS_DIR, "GCONF_ERROR_IS_DIR", "is-dir" },
  { GCONF_ERROR_IS_KEY, "GCONF_ERROR_IS_KEY", "is-key" },
  { GCONF_ERROR_OVERRIDDEN, "GCONF_ERROR_OVERRIDDEN", "overridden" },
  { GCONF_ERROR_OAF_ERROR, "GCONF_ERROR_OAF_ERROR", "oaf-error" },
  { GCONF_ERROR_LOCAL_ENGINE, "GCONF_ERROR_LOCAL_ENGINE", "local-engine" },
  { GCONF_ERROR_LOCK_FAILED, "GCONF_ERROR_LOCK_FAILED", "lock-failed" },
  { GCONF_ERROR_NO_WRITABLE_DATABASE, "GCONF_ERROR_NO_WRITABLE_DATABASE", "no-writable-database" },
  { GCONF_ERROR_IN_SHUTDOWN, "GCONF_ERROR_IN_SHUTDOWN", "in-shutdown" },
  { 0, NULL, NULL },
};

GType
gconfperl_gconf_error_get_type (void)
{
  static GType type = 0;

  if (! type)
    type = g_enum_register_static ("GConfPerlError", _gconfperl_gconf_error_values);
  
  return type;
}


MODULE = Gnome2::GConf	PACKAGE = Gnome2::GConf PREFIX = gconf_

=for object Gnome2::GConf::main

=cut


BOOT:
#include "register.xsh"
#include "boot.xsh"
	gperl_register_error_domain (GCONF_ERROR,
			             GCONFPERL_TYPE_GCONF_ERROR,
				     "Gnome2::GConf::Error");


=for apidoc
=signature (major_version, minor_version, micro_version) = Gnome2::GConf->GET_VERSION_INFO
=cut
void
GET_VERSION_INFO (class)
    PPCODE:
	EXTEND (SP, 3);
	PUSHs (sv_2mortal (newSViv (GCONF_MAJOR_VERSION)));
	PUSHs (sv_2mortal (newSViv (GCONF_MINOR_VERSION)));
	PUSHs (sv_2mortal (newSViv (GCONF_MICRO_VERSION)));
	PERL_UNUSED_VAR (ax);

gboolean
CHECK_VERSION (class, major, minor, micro)
	int major
	int minor
	int micro
    CODE:
	RETVAL = GCONF_CHECK_VERSION (major, minor, micro);
    OUTPUT:
	RETVAL
