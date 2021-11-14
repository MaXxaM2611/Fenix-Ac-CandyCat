import React from 'react';
import { mdiAccountGroup } from '@mdi/js';
import { mdiGavel } from '@mdi/js';
import { mdiCog } from '@mdi/js';
import { mdiInformation } from '@mdi/js';
import { mdiTune } from '@mdi/js';
import { mdiFileKey } from '@mdi/js';
import Icon from '@mdi/react'
import { mdiShieldAccount } from '@mdi/js';

export const SidebarData = [
    {
        title: "Information",
        icon: <Icon path={mdiInformation} />,
        link: "/informazioni"
    },
    {
        title: "Players List",
        icon: <Icon path={mdiAccountGroup} />,
        link: "/listaplayer"
    },
    {
        title: "Ban List",
        icon: <Icon path={mdiGavel} />,
        link: "/listaban"
    },
    {
        title: "Settings",
        icon: <Icon path={mdiTune} />,
        link: "/settings"
    },
    {
        title: "Roles",
        icon: <Icon path={mdiFileKey} />,
        link: "/configtable"
    },
    {
        title: "Accounts",
        icon: <Icon path={mdiShieldAccount} />,
        link: "/accounts"
    }
]