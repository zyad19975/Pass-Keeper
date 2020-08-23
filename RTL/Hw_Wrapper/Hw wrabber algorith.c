
    if (rst)
    {
        reset();
    }
    for (int i = 0; i < max_add_flash; i++)
    {
        write_on_cam(flash[i]);
    }
    while(1){
    while(!go);
    cin>>account;
    match = read_cam(account);
    if (match){
        pass_enc = flash[match_addr];
        PASS = dec(pass_enc);
        pass_session = enc(pass, master_key);
        out;    
    }else
    {
        cin>>pass_new;
        pass_new_enc = enc(pass_new,local_key);
        dataflash= account + pass_new_enc;
        flash[max_add + 1 ] = dataflash;
    }
    

    }
