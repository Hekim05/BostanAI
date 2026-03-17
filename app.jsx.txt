import { useState, useEffect, useRef } from "react";
import { AreaChart, Area, BarChart, Bar, PieChart, Pie, Cell, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend } from "recharts";

const C = {
  bg:"#FAFAFA",bgWarm:"#FFF8F0",card:"#FFFFFF",
  green1:"#10B981",green2:"#34D399",green3:"#6EE7B7",green4:"#A7F3D0",green5:"#ECFDF5",
  greenDark:"#047857",greenDeep:"#065F46",
  terra:"#D97706",terraLight:"#FEF3C7",amber:"#F59E0B",amberLight:"#FEF3C7",
  coral:"#EF4444",sky:"#06B6D4",
  text:"#1F2937",textSoft:"#6B7280",textMuted:"#D1D5DB",
  border:"#E5E7EB",borderLight:"#F3F4F6",
  shadow:"0 1px 3px rgba(0,0,0,0.08), 0 4px 12px rgba(0,0,0,0.05)",
  shadowLg:"0 10px 25px rgba(0,0,0,0.1), 0 20px 40px rgba(0,0,0,0.08)",
};

const Icon = ({name, size=20, color=C.text}) => {
  const d = {
    home:"M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-4 0a1 1 0 01-1-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 01-1 1",
    users:"M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z",
    clipboard:"M9 5H7a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01",
    grid:"M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z",
    calendar:"M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z",
    bell:"M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9",
    plus:"M12 4v16m8-8H4",
    search:"M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z",
    check:"M5 13l4 4L19 7",
    menu:"M4 6h16M4 12h16M4 18h16",
    edit:"M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z",
    box:"M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4",
    chart:"M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z",
    alert:"M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z",
    lock:"M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z",
    logout:"M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1",
    msg:"M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z",
    person:"M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z",
    heart:"M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z",
    sun:"M12 3v1m0 16v1m8.66-13.66l-.71.71M4.05 19.95l-.71.71M21 12h-1M4 12H3m16.95 7.95l-.71-.71M4.76 4.05l-.71-.71M16 12a4 4 0 11-8 0 4 4 0 018 0z",
  };
  return <svg width={size} height={size} fill="none" stroke={color} strokeWidth={1.8} strokeLinecap="round" strokeLinejoin="round" viewBox="0 0 24 24"><path d={d[name] || d.home}/></svg>;
};

const Badge = ({children, color=C.green1}) => (
  <span style={{display:"inline-flex",alignItems:"center",padding:"3px 10px",borderRadius:20,fontSize:11,fontWeight:700,color,background:color+"14"}}>{children}</span>
);

const StatCard = ({icon, label, value, sub, color, delay=0}) => (
  <div style={{background:C.card,borderRadius:14,padding:"20px 24px",border:"1px solid "+C.borderLight,boxShadow:C.shadow,display:"flex",alignItems:"center",gap:16,animation:"fadeUp 0.5s ease "+delay+"s both",transition:"all 0.3s ease",cursor:"pointer"}}>
    <div style={{width:50,height:50,borderRadius:12,background:"linear-gradient(135deg,"+color+"25,"+color+"10)",display:"flex",alignItems:"center",justifyContent:"center",flex:"0 0 auto"}}><Icon name={icon} size={22} color={color}/></div>
    <div style={{flex:1}}>
      <div style={{fontSize:12,color:C.textMuted,fontWeight:500,textTransform:"uppercase",letterSpacing:"0.5px"}}>{label}</div>
      <div style={{fontSize:28,fontWeight:800,color:C.text,lineHeight:1.1,marginTop:4}}>{value}</div>
      {sub && <div style={{fontSize:12,color:C.textSoft,marginTop:4}}>{sub}</div>}
    </div>
  </div>
);

const CTooltip = ({active, payload, label}) => {
  if (!active || !payload) return null;
  return (
    <div style={{background:"#fff",padding:"8px 12px",borderRadius:10,boxShadow:"0 4px 16px rgba(0,0,0,0.1)",border:"1px solid "+C.borderLight,fontSize:12}}>
      <div style={{fontWeight:700,marginBottom:3}}>{label}</div>
      {payload.map(function(p, i) { return <div key={i} style={{color:p.color,display:"flex",gap:6}}><span>{p.name}:</span><b>{p.value}</b></div>; })}
    </div>
  );
};

const Btn = ({children, primary, small, icon, onClick, disabled}) => (
  <button onClick={onClick} disabled={disabled} style={{
    display:"flex",alignItems:"center",gap:5,
    padding:small ? "7px 13px" : "10px 20px",
    background:primary ? "linear-gradient(135deg,"+C.green1+","+C.greenDark+")" : C.card,
    color:primary ? "#fff" : C.text,
    border:primary ? "none" : "1px solid "+C.border,
    borderRadius:11,fontSize:small ? 12 : 13,fontWeight:700,
    cursor:disabled ? "not-allowed" : "pointer",
    boxShadow:primary ? "0 2px 10px "+C.green1+"35" : "none",
    opacity:disabled ? 0.5 : 1
  }}>
    {icon && <Icon name={icon} size={small ? 13 : 15} color={primary ? "#fff" : C.text}/>}
    {children}
  </button>
);

/* ====== DATA ====== */
const BOSTANLAR = {
  mutlukent: {
    ad:"Mutlukent Kent Bostani",kisa:"Mutlukent",emoji:"\uD83C\uDF3B",renk:"#4CAF50",
    kursiyerler:[
      {id:1,ad:"Ahmet Yilmaz",tc:"123***890",tel:"0532 111 2233",parsel:"1",kurs:"Organik Tarim",durum:"Aktif",kayit:"2024-09-15"},
      {id:2,ad:"Fatma Demir",tc:"234***901",tel:"0533 222 3344",parsel:"3",kurs:"Sebze Yetistirme",durum:"Aktif",kayit:"2024-10-01"},
      {id:3,ad:"Mehmet Kara",tc:"345***012",tel:"0535 333 4455",parsel:"-",kurs:"Organik Tarim",durum:"Beklemede",kayit:"2025-01-12"},
      {id:4,ad:"Zeynep Arslan",tc:"456***123",tel:"0536 444 5566",parsel:"5",kurs:"Bitki Bakimi",durum:"Aktif",kayit:"2024-11-20"},
    ],
    personel:[
      {id:1,ad:"Ali Vural",rol:"Bahce Sorumlusu",tel:"0541 100 2000",durum:"Aktif",izinKalan:12,izinler:[{tarih:"2025-02-10",gun:3,durum:"Onayli"},{tarih:"2025-01-05",gun:1,durum:"Onayli"}]},
      {id:2,ad:"Elif Korkmaz",rol:"Koordinator",tel:"0542 200 3000",durum:"Aktif",izinKalan:8,izinler:[{tarih:"2025-03-01",gun:5,durum:"Beklemede"}]},
    ],
    parseller:[
      {id:"1",kursiyer:"Ahmet Yilmaz",urun:"Domates, Biber",ekim:"2025-03-10",durum:"Dolu"},
      {id:"2",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"3",kursiyer:"Fatma Demir",urun:"Salatalik, Marul",ekim:"2025-03-15",durum:"Dolu"},
      {id:"4",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"5",kursiyer:"Zeynep Arslan",urun:"Fasulye",ekim:"2025-04-01",durum:"Dolu"},
      {id:"6",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"7",kursiyer:"Selin Ozkan",urun:"Biber, Patlican",ekim:"2025-03-20",durum:"Dolu"},
      {id:"8",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"9",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"10",kursiyer:"-",urun:"-",ekim:"-",durum:"Bakimda"},
      {id:"11",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"12",kursiyer:"Kemal Aydin",urun:"Domates",ekim:"2025-04-05",durum:"Dolu"},
      {id:"13",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"14",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"15",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"16",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"17",kursiyer:"Hatice Polat",urun:"Kabak, Fasulye",ekim:"2025-03-25",durum:"Dolu"},
      {id:"18",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"19",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"20",kursiyer:"-",urun:"-",ekim:"-",durum:"Bakimda"},
      {id:"21",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"22",kursiyer:"Murat Kose",urun:"Salatalik",ekim:"2025-04-10",durum:"Dolu"},
      {id:"23",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"24",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"25",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"26",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"27",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"28",kursiyer:"Emine Tas",urun:"Marul, Roka",ekim:"2025-04-01",durum:"Dolu"},
      {id:"29",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"30",kursiyer:"-",urun:"-",ekim:"-",durum:"Bakimda"},
      {id:"31",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"32",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"33",kursiyer:"Baris Cetin",urun:"Domates, Biber",ekim:"2025-03-28",durum:"Dolu"},
      {id:"34",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"35",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"36",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"}
    ],
    envanter:[
      {id:1,ad:"Domates Tohumu",kat:"Tohum",stok:45,min:20,birim:"pkt",fiyat:15,konum:"Depo A"},
      {id:2,ad:"Organik Gubre",kat:"Gubre",stok:8,min:10,birim:"kg",fiyat:32,konum:"Depo B"},
      {id:3,ad:"Bahce Makasi",kat:"Alet",stok:12,min:5,birim:"adet",fiyat:85,konum:"Atolye"},
      {id:4,ad:"Biber Tohumu",kat:"Tohum",stok:30,min:15,birim:"pkt",fiyat:12,konum:"Depo A"},
      {id:5,ad:"Sulama Hortumu",kat:"Alet",stok:3,min:5,birim:"adet",fiyat:120,konum:"Atolye"},
      {id:6,ad:"Kompost",kat:"Gubre",stok:25,min:10,birim:"kg",fiyat:18,konum:"Depo B"},
    ],
    gorevler:[
      {id:1,baslik:"A Blok sulama sistemi kontrolu",atanan:"Ali V.",oncelik:"Yuksek",durum:"Devam Ediyor",tarih:"Bu hafta"},
      {id:2,baslik:"B-01 parsel toprak analizi",atanan:"Elif K.",oncelik:"Orta",durum:"Bekliyor",tarih:"15 Mart"},
      {id:3,baslik:"Kompost alani duzenleme",atanan:"Ali V.",oncelik:"Dusuk",durum:"Tamamlandi",tarih:"Gecen hafta"},
    ],
    kurslar:[
      {id:1,ad:"Organik Tarim 101",egitmen:"Prof. Ayse Celik",bas:"2025-03-01",bit:"2025-05-30",kont:20,kay:18,durum:"Devam Ediyor"},
      {id:2,ad:"Kompost Hazirlama",egitmen:"Mehmet Toprak",bas:"2025-06-01",bit:"2025-07-15",kont:15,kay:7,durum:"Kayit Acik"},
    ],
    hasat:[{ay:"Mar",kg:0},{ay:"Nis",kg:25},{ay:"May",kg:120},{ay:"Haz",kg:280},{ay:"Tem",kg:480},{ay:"Agu",kg:350}],
  },
  ata: {
    ad:"Ata Kent Bostani",kisa:"Ata",emoji:"\uD83C\uDF3F",renk:"#2196F3",
    kursiyerler:[
      {id:5,ad:"Hasan Ozturk",tc:"567***234",tel:"0537 555 6677",parsel:"1",kurs:"Sebze Yetistirme",durum:"Aktif",kayit:"2024-08-20"},
      {id:6,ad:"Ayse Sahin",tc:"678***345",tel:"0538 666 7788",parsel:"2",kurs:"Organik Tarim",durum:"Aktif",kayit:"2024-09-05"},
      {id:7,ad:"Mustafa Celik",tc:"789***456",tel:"0539 777 8899",parsel:"-",kurs:"Bitki Bakimi",durum:"Tamamladi",kayit:"2024-06-10"},
    ],
    personel:[
      {id:3,ad:"Murat Beyaz",rol:"Bahce Sorumlusu",tel:"0543 300 4000",durum:"Aktif",izinKalan:14,izinler:[]},
      {id:4,ad:"Ayhan Tunc",rol:"Teknisyen",tel:"0544 400 5000",durum:"Aktif",izinKalan:10,izinler:[{tarih:"2025-02-20",gun:2,durum:"Onayli"}]},
    ],
    parseller:[
      {id:"1",kursiyer:"Hasan Ozturk",urun:"Kabak, Patlican",ekim:"2025-03-05",durum:"Dolu"},
      {id:"2",kursiyer:"Ayse Sahin",urun:"Domates",ekim:"2025-03-12",durum:"Dolu"},
      {id:"3",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"4",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"5",kursiyer:"Cengiz Acar",urun:"Biber, Fasulye",ekim:"2025-04-02",durum:"Dolu"},
      {id:"6",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"},
      {id:"7",kursiyer:"-",urun:"-",ekim:"-",durum:"Bakimda"},
      {id:"8",kursiyer:"-",urun:"-",ekim:"-",durum:"Bos"}
    ],
    envanter:[
      {id:7,ad:"Kabak Tohumu",kat:"Tohum",stok:20,min:10,birim:"pkt",fiyat:10,konum:"Depo C"},
      {id:8,ad:"Solucan Gubresi",kat:"Gubre",stok:5,min:8,birim:"kg",fiyat:45,konum:"Depo C"},
      {id:9,ad:"Kurek",kat:"Alet",stok:8,min:4,birim:"adet",fiyat:65,konum:"Atolye 2"},
      {id:10,ad:"Patlican Tohumu",kat:"Tohum",stok:18,min:10,birim:"pkt",fiyat:14,konum:"Depo C"},
      {id:11,ad:"Damlama Seti",kat:"Alet",stok:2,min:3,birim:"adet",fiyat:200,konum:"Atolye 2"},
    ],
    gorevler:[
      {id:4,baslik:"C Blok sulama testi",atanan:"Murat B.",oncelik:"Orta",durum:"Devam Ediyor",tarih:"Bu hafta"},
      {id:5,baslik:"D-01 parsel iyilestirme",atanan:"Ayhan T.",oncelik:"Yuksek",durum:"Tamamlandi",tarih:"Gecen hafta"},
      {id:6,baslik:"Yeni parsel hazirligi",atanan:"Ayhan T.",oncelik:"Yuksek",durum:"Bekliyor",tarih:"Bu hafta"},
    ],
    kurslar:[
      {id:3,ad:"Sebze Yetistirme",egitmen:"Kemal Toprak",bas:"2025-04-15",bit:"2025-06-15",kont:15,kay:15,durum:"Devam Ediyor"},
      {id:4,ad:"Bitki Bakimi",egitmen:"Dr. Selma Ay",bas:"2025-07-01",bit:"2025-08-30",kont:20,kay:3,durum:"Kayit Acik"},
    ],
    hasat:[{ay:"Mar",kg:0},{ay:"Nis",kg:15},{ay:"May",kg:98},{ay:"Haz",kg:210},{ay:"Tem",kg:360},{ay:"Agu",kg:285}],
  }
};

var initEvents = [
  {id:1,tarih:"2026-01-14",saat:"12:30",baslik:"Meyve Agaclarinda Budama",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:2,tarih:"2026-01-21",saat:"12:30",baslik:"Gul, Cali Budamasi",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:3,tarih:"2026-01-28",saat:"12:30",baslik:"Asilama ve Asma Budamasi",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:4,tarih:"2026-02-04",saat:"12:30",baslik:"Yerel Tohumun Onemi / Tohumdan Fideye",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:5,tarih:"2026-02-11",saat:"12:30",baslik:"Sebzelerde Hastaliklar / Yasayan Toprak",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:6,tarih:"2026-02-18",saat:"12:30",baslik:"Bahcenizi Guzellestirme Teknikleri",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:7,tarih:"2026-02-25",saat:"12:30",baslik:"Dis Mekan Bitkilerini Taniyalim",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:8,tarih:"2026-03-04",saat:"12:30",baslik:"100m2 Bostan Kurulumu / Ugurbocegi Uretimi",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:9,tarih:"2026-03-11",saat:"12:30",baslik:"Meyve Agaclarinin Yetistirilmesi",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:10,tarih:"2026-03-18",saat:"12:30",baslik:"Sulama Sistemlerinde Pratik Bilgiler",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:11,tarih:"2026-03-25",saat:"12:30",baslik:"Terraryum Nasil Yapilir? / Uygulama",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:12,tarih:"2026-04-01",saat:"12:30",baslik:"Yagmur Suyu Hasadi",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:13,tarih:"2026-04-08",saat:"12:30",baslik:"Domates, Biber Nasil Yetistirilir?",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:14,tarih:"2026-04-15",saat:"12:30",baslik:"Salatalik, Fasulye Nasil Yetistirilir?",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:15,tarih:"2026-04-22",saat:"12:30",baslik:"Misir, Kabak ve Kavun Nasil Yetistirilir?",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:16,tarih:"2026-04-29",saat:"12:30",baslik:"Cilek, Marul Nasil Yetistirilir?",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:17,tarih:"2026-05-06",saat:"12:30",baslik:"Evde Kompost ve Solucan Gubresi Yapimi",tip:"egitim",bostan:"mutlukent",bildirim:true},
  {id:18,tarih:"2026-01-15",saat:"13:00",baslik:"Meyve Agaclarinda Budama",tip:"egitim",bostan:"ata",bildirim:true},
  {id:19,tarih:"2026-01-22",saat:"13:00",baslik:"Gul, Cali Budamasi",tip:"egitim",bostan:"ata",bildirim:true},
  {id:20,tarih:"2026-01-29",saat:"13:00",baslik:"Asilama ve Asma Budamasi",tip:"egitim",bostan:"ata",bildirim:true},
  {id:21,tarih:"2026-02-05",saat:"13:00",baslik:"Yerel Tohumun Onemi / Tohumdan Fideye",tip:"egitim",bostan:"ata",bildirim:true},
  {id:22,tarih:"2026-02-12",saat:"13:00",baslik:"Sebzelerde Hastaliklar / Yasayan Toprak",tip:"egitim",bostan:"ata",bildirim:true},
  {id:23,tarih:"2026-02-19",saat:"13:00",baslik:"Bahcenizi Guzellestirme Teknikleri",tip:"egitim",bostan:"ata",bildirim:true},
  {id:24,tarih:"2026-02-26",saat:"13:00",baslik:"Dis Mekan Bitkilerini Taniyalim",tip:"egitim",bostan:"ata",bildirim:true},
  {id:25,tarih:"2026-03-05",saat:"13:00",baslik:"100m2 Bostan Kurulumu / Ugurbocegi Uretimi",tip:"egitim",bostan:"ata",bildirim:true},
  {id:26,tarih:"2026-03-12",saat:"13:00",baslik:"Meyve Agaclarinin Yetistirilmesi",tip:"egitim",bostan:"ata",bildirim:true},
  {id:27,tarih:"2026-03-26",saat:"13:00",baslik:"Sulama Sistemlerinde Pratik Bilgiler",tip:"egitim",bostan:"ata",bildirim:true},
  {id:28,tarih:"2026-04-02",saat:"13:00",baslik:"Terraryum Nasil Yapilir? / Uygulama",tip:"egitim",bostan:"ata",bildirim:true},
  {id:29,tarih:"2026-04-09",saat:"13:00",baslik:"Yagmur Suyu Hasadi",tip:"egitim",bostan:"ata",bildirim:true},
  {id:30,tarih:"2026-04-16",saat:"13:00",baslik:"Domates, Biber Nasil Yetistirilir?",tip:"egitim",bostan:"ata",bildirim:true},
  {id:31,tarih:"2026-04-30",saat:"13:00",baslik:"Salatalik, Fasulye Nasil Yetistirilir?",tip:"egitim",bostan:"ata",bildirim:true},
  {id:32,tarih:"2026-05-07",saat:"13:00",baslik:"Misir, Kabak ve Kavun Nasil Yetistirilir?",tip:"egitim",bostan:"ata",bildirim:true},
  {id:33,tarih:"2026-05-14",saat:"13:00",baslik:"Cilek, Marul Nasil Yetistirilir?",tip:"egitim",bostan:"ata",bildirim:true},
  {id:34,tarih:"2026-05-21",saat:"13:00",baslik:"Evde Kompost ve Solucan Gubresi Yapimi",tip:"egitim",bostan:"ata",bildirim:true},
  {id:35,tarih:"2026-02-26",saat:"09:00",baslik:"Fesle./Papatya/Ekinezya/Kadife torf hazirla",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:36,tarih:"2026-02-26",saat:"09:00",baslik:"Fesle./Papatya/Ekinezya/Kadife torf hazirla",tip:"ekim",bostan:"ata",bildirim:false},
  {id:37,tarih:"2026-02-27",saat:"09:00",baslik:"Fesle./Papatya/Ekinezya/Kadife tohum ek",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:38,tarih:"2026-02-27",saat:"09:00",baslik:"Fesle./Papatya/Ekinezya/Kadife tohum ek",tip:"ekim",bostan:"ata",bildirim:false},
  {id:39,tarih:"2026-03-09",saat:"09:00",baslik:"Biber 1.Parti torf hazirla",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:40,tarih:"2026-03-09",saat:"09:00",baslik:"Biber 1.Parti torf hazirla",tip:"ekim",bostan:"ata",bildirim:false},
  {id:41,tarih:"2026-03-10",saat:"09:00",baslik:"Biber 1.Parti tohum ek",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:42,tarih:"2026-03-10",saat:"09:00",baslik:"Biber 1.Parti tohum ek",tip:"ekim",bostan:"ata",bildirim:false},
  {id:43,tarih:"2026-03-16",saat:"09:00",baslik:"Biber 2.Parti torf hazirla",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:44,tarih:"2026-03-16",saat:"09:00",baslik:"Biber 2.Parti torf hazirla",tip:"ekim",bostan:"ata",bildirim:false},
  {id:45,tarih:"2026-03-17",saat:"09:00",baslik:"Biber 2.Parti tohum ek",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:46,tarih:"2026-03-17",saat:"09:00",baslik:"Biber 2.Parti tohum ek",tip:"ekim",bostan:"ata",bildirim:false},
  {id:47,tarih:"2026-03-20",saat:"09:00",baslik:"Fesle./Papatya/Ekinezya/Kadife sasirt",tip:"dikim",bostan:"mutlukent",bildirim:false},
  {id:48,tarih:"2026-03-20",saat:"09:00",baslik:"Fesle./Papatya/Ekinezya/Kadife sasirt",tip:"dikim",bostan:"ata",bildirim:false},
  {id:49,tarih:"2026-03-24",saat:"09:00",baslik:"Domates 1.Parti torf hazirla",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:50,tarih:"2026-03-24",saat:"09:00",baslik:"Domates 1.Parti torf hazirla",tip:"ekim",bostan:"ata",bildirim:false},
  {id:51,tarih:"2026-03-25",saat:"09:00",baslik:"Domates 1.Parti tohum ek",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:52,tarih:"2026-03-25",saat:"09:00",baslik:"Domates 1.Parti tohum ek",tip:"ekim",bostan:"ata",bildirim:false},
  {id:53,tarih:"2026-03-31",saat:"09:00",baslik:"Maydanoz torf + Domates 2.Parti hazirla",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:54,tarih:"2026-03-31",saat:"09:00",baslik:"Maydanoz torf + Domates 2.Parti hazirla",tip:"ekim",bostan:"ata",bildirim:false},
  {id:55,tarih:"2026-04-01",saat:"09:00",baslik:"Maydanoz + Domates 2.Parti tohum ek",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:56,tarih:"2026-04-01",saat:"09:00",baslik:"Maydanoz + Domates 2.Parti tohum ek",tip:"ekim",bostan:"ata",bildirim:false},
  {id:57,tarih:"2026-04-07",saat:"09:00",baslik:"K.Kabak 1.Parti torf hazirla",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:58,tarih:"2026-04-07",saat:"09:00",baslik:"K.Kabak 1.Parti torf hazirla",tip:"ekim",bostan:"ata",bildirim:false},
  {id:59,tarih:"2026-04-08",saat:"09:00",baslik:"Kavun torf hazirla",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:60,tarih:"2026-04-08",saat:"09:00",baslik:"Kavun torf hazirla",tip:"ekim",bostan:"ata",bildirim:false},
  {id:61,tarih:"2026-04-08",saat:"09:00",baslik:"K.Kabak 1.Parti tohum ek",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:62,tarih:"2026-04-08",saat:"09:00",baslik:"K.Kabak 1.Parti tohum ek",tip:"ekim",bostan:"ata",bildirim:false},
  {id:63,tarih:"2026-04-09",saat:"09:00",baslik:"Kavun tohum ek",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:64,tarih:"2026-04-09",saat:"09:00",baslik:"Kavun tohum ek",tip:"ekim",bostan:"ata",bildirim:false},
  {id:65,tarih:"2026-04-09",saat:"09:00",baslik:"Biber 1.Parti sasirt (48lik)",tip:"dikim",bostan:"mutlukent",bildirim:false},
  {id:66,tarih:"2026-04-09",saat:"09:00",baslik:"Biber 1.Parti sasirt (48lik)",tip:"dikim",bostan:"ata",bildirim:false},
  {id:67,tarih:"2026-04-13",saat:"09:00",baslik:"Roka/Havuc/Salatalik 1.Parti torf hazirla",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:68,tarih:"2026-04-13",saat:"09:00",baslik:"Roka/Havuc/Salatalik 1.Parti torf hazirla",tip:"ekim",bostan:"ata",bildirim:false},
  {id:69,tarih:"2026-04-14",saat:"09:00",baslik:"K.Kabak 2P + Marul + Kivircik torf hazirla",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:70,tarih:"2026-04-14",saat:"09:00",baslik:"K.Kabak 2P + Marul + Kivircik torf hazirla",tip:"ekim",bostan:"ata",bildirim:false},
  {id:71,tarih:"2026-04-14",saat:"09:00",baslik:"Roka/Havuc/Salatalik tohum ek",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:72,tarih:"2026-04-14",saat:"09:00",baslik:"Roka/Havuc/Salatalik tohum ek",tip:"ekim",bostan:"ata",bildirim:false},
  {id:73,tarih:"2026-04-15",saat:"09:00",baslik:"Misir torf hazirla",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:74,tarih:"2026-04-15",saat:"09:00",baslik:"Misir torf hazirla",tip:"ekim",bostan:"ata",bildirim:false},
  {id:75,tarih:"2026-04-15",saat:"09:00",baslik:"K.Kabak 2P + Marul + Kivircik tohum ek",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:76,tarih:"2026-04-15",saat:"09:00",baslik:"K.Kabak 2P + Marul + Kivircik tohum ek",tip:"ekim",bostan:"ata",bildirim:false},
  {id:77,tarih:"2026-04-16",saat:"09:00",baslik:"Misir tohum ek",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:78,tarih:"2026-04-16",saat:"09:00",baslik:"Misir tohum ek",tip:"ekim",bostan:"ata",bildirim:false},
  {id:79,tarih:"2026-04-16",saat:"09:00",baslik:"Biber 2.Parti sasirt",tip:"dikim",bostan:"mutlukent",bildirim:false},
  {id:80,tarih:"2026-04-16",saat:"09:00",baslik:"Biber 2.Parti sasirt",tip:"dikim",bostan:"ata",bildirim:false},
  {id:81,tarih:"2026-04-19",saat:"09:00",baslik:"Maydanoz + Domates 1P sasirt",tip:"dikim",bostan:"mutlukent",bildirim:false},
  {id:82,tarih:"2026-04-19",saat:"09:00",baslik:"Maydanoz + Domates 1P sasirt",tip:"dikim",bostan:"ata",bildirim:false},
  {id:83,tarih:"2026-04-20",saat:"09:00",baslik:"Salatalik 2P + Fasulye torf hazirla",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:84,tarih:"2026-04-20",saat:"09:00",baslik:"Salatalik 2P + Fasulye torf hazirla",tip:"ekim",bostan:"ata",bildirim:false},
  {id:85,tarih:"2026-04-21",saat:"09:00",baslik:"Salatalik 2P + Fasulye tohum ek",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:86,tarih:"2026-04-21",saat:"09:00",baslik:"Salatalik 2P + Fasulye tohum ek",tip:"ekim",bostan:"ata",bildirim:false},
  {id:87,tarih:"2026-04-22",saat:"09:00",baslik:"Salatalik 1P + K.Kabak 1P sasirt",tip:"dikim",bostan:"mutlukent",bildirim:false},
  {id:88,tarih:"2026-04-22",saat:"09:00",baslik:"Salatalik 1P + K.Kabak 1P sasirt",tip:"dikim",bostan:"ata",bildirim:false},
  {id:89,tarih:"2026-04-26",saat:"09:00",baslik:"Domates 2P + Kavun sasirt",tip:"dikim",bostan:"mutlukent",bildirim:false},
  {id:90,tarih:"2026-04-26",saat:"09:00",baslik:"Domates 2P + Kavun sasirt",tip:"dikim",bostan:"ata",bildirim:false},
  {id:91,tarih:"2026-04-29",saat:"09:00",baslik:"Marul/Kivircik/Roka/Havuc sasirt",tip:"dikim",bostan:"mutlukent",bildirim:false},
  {id:92,tarih:"2026-04-29",saat:"09:00",baslik:"Marul/Kivircik/Roka/Havuc sasirt",tip:"dikim",bostan:"ata",bildirim:false},
  {id:93,tarih:"2026-05-03",saat:"09:00",baslik:"K.Kabak 2P + Misir + Fasulye sasirt",tip:"dikim",bostan:"mutlukent",bildirim:false},
  {id:94,tarih:"2026-05-03",saat:"09:00",baslik:"K.Kabak 2P + Misir + Fasulye sasirt",tip:"dikim",bostan:"ata",bildirim:false},
  {id:95,tarih:"2026-05-06",saat:"09:00",baslik:"Salatalik 2P sasirt",tip:"dikim",bostan:"mutlukent",bildirim:false},
  {id:96,tarih:"2026-05-06",saat:"09:00",baslik:"Salatalik 2P sasirt",tip:"dikim",bostan:"ata",bildirim:false},
  {id:97,tarih:"2026-05-15",saat:"09:00",baslik:"GENEL DIKIM GUNU - Tum fideler parsellere",tip:"dikim",bostan:"mutlukent",bildirim:false},
  {id:98,tarih:"2026-05-15",saat:"09:00",baslik:"GENEL DIKIM GUNU - Tum fideler parsellere",tip:"dikim",bostan:"ata",bildirim:false},
  {id:99,tarih:"2026-02-12",saat:"09:00",baslik:"Is: Egitimler",tip:"egitim",bostan:"mutlukent",bildirim:false},
  {id:100,tarih:"2026-03-12",saat:"09:00",baslik:"Is: Tohum Atma",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:101,tarih:"2026-04-12",saat:"09:00",baslik:"Is: Fideleme/Sasirtma",tip:"dikim",bostan:"mutlukent",bildirim:false},
  {id:102,tarih:"2026-02-05",saat:"09:00",baslik:"Is: Bahcivanlik",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:103,tarih:"2026-05-19",saat:"09:00",baslik:"Is: Fide Dikim",tip:"dikim",bostan:"mutlukent",bildirim:false},
  {id:104,tarih:"2026-04-19",saat:"09:00",baslik:"Is: Bokasi Kompost Yapimi",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:105,tarih:"2026-03-12",saat:"09:00",baslik:"Is: Enzim Uretimi",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:106,tarih:"2026-04-26",saat:"09:00",baslik:"Is: Toprak Hazirligi",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:107,tarih:"2026-04-05",saat:"09:00",baslik:"Is: Skulent/Kaktus Uretimi",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:108,tarih:"2026-04-19",saat:"09:00",baslik:"Is: Ugurbocegi Uretimi",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:109,tarih:"2026-03-05",saat:"09:00",baslik:"Is: Tohum Takas Etkinligi",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:110,tarih:"2026-08-05",saat:"09:00",baslik:"Is: Tohum Alma",tip:"ekim",bostan:"mutlukent",bildirim:false},
  {id:111,tarih:"2026-02-19",saat:"09:00",baslik:"Is: Ahududu/Bogurtlen Bakimi",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:112,tarih:"2026-02-19",saat:"08:00",baslik:"Bokasi - Kova Tahsisi",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:113,tarih:"2026-02-19",saat:"08:00",baslik:"Bokasi - Kova Tahsisi",tip:"besleme",bostan:"ata",bildirim:false},
  {id:114,tarih:"2026-02-19",saat:"08:00",baslik:"Bokasi - Yapim",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:115,tarih:"2026-02-19",saat:"08:00",baslik:"Bokasi - Yapim",tip:"besleme",bostan:"ata",bildirim:false},
  {id:116,tarih:"2026-02-12",saat:"08:00",baslik:"Fermenter - Yapim",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:117,tarih:"2026-02-12",saat:"08:00",baslik:"Fermenter - Yapim",tip:"besleme",bostan:"ata",bildirim:false},
  {id:118,tarih:"2026-02-12",saat:"08:00",baslik:"Enzim - Yapim",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:119,tarih:"2026-02-12",saat:"08:00",baslik:"Enzim - Yapim",tip:"besleme",bostan:"ata",bildirim:false},
  {id:120,tarih:"2026-03-12",saat:"08:00",baslik:"Kukurt Uygulamasi",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:121,tarih:"2026-03-12",saat:"08:00",baslik:"Kukurt Uygulamasi",tip:"besleme",bostan:"ata",bildirim:false},
  {id:122,tarih:"2026-02-19",saat:"08:00",baslik:"Humik Asit Uygulamasi",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:123,tarih:"2026-02-19",saat:"08:00",baslik:"Humik Asit Uygulamasi",tip:"besleme",bostan:"ata",bildirim:false},
  {id:124,tarih:"2026-03-26",saat:"08:00",baslik:"Hayvan Gubresi",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:125,tarih:"2026-03-26",saat:"08:00",baslik:"Hayvan Gubresi",tip:"besleme",bostan:"ata",bildirim:false},
  {id:126,tarih:"2026-03-26",saat:"08:00",baslik:"Solucan Gubresi",tip:"besleme",bostan:"mutlukent",bildirim:false},
  {id:127,tarih:"2026-03-26",saat:"08:00",baslik:"Solucan Gubresi",tip:"besleme",bostan:"ata",bildirim:false}
];

var initSorular = [
  {id:1,gonderen:"Murat Beyaz",bostan:"mutlukent",soru:"A Blok hortumlari eskimis, yeni siparis ne zaman gelir?",tarih:"2026-03-01",cevap:"Siparis verildi, 1 hafta icinde gelecek.",durum:"Cevaplandi"},
  {id:2,gonderen:"Ayhan Tunc",bostan:"ata",soru:"D Blok icin ilaclama izni gerekli mi?",tarih:"2026-03-02",cevap:"",durum:"Bekliyor"},
  {id:3,gonderen:"Elif Korkmaz",bostan:"mutlukent",soru:"Kompost alani icin ek malzeme lazim.",tarih:"2026-03-03",cevap:"",durum:"Bekliyor"},
];
var TATILLER = {
  "2026-01-01":"Yilbasi",
  "2026-03-19":"Ramazan Bayrami Arifesi",
  "2026-03-20":"Ramazan Bayrami 1. Gun",
  "2026-03-21":"Ramazan Bayrami 2. Gun",
  "2026-03-22":"Ramazan Bayrami 3. Gun",
  "2026-04-23":"23 Nisan Ulusal Egemenlik ve Cocuk Bayrami",
  "2026-05-01":"1 Mayis Emek ve Dayanisma Gunu",
  "2026-05-19":"19 Mayis Genclik ve Spor Bayrami",
  "2026-05-26":"Kurban Bayrami Arifesi",
  "2026-05-27":"Kurban Bayrami 1. Gun",
  "2026-05-28":"Kurban Bayrami 2. Gun",
  "2026-05-29":"Kurban Bayrami 3. Gun",
  "2026-05-30":"Kurban Bayrami 4. Gun",
  "2026-07-15":"15 Temmuz Demokrasi ve Milli Birlik Gunu",
  "2026-08-30":"30 Agustos Zafer Bayrami",
  "2026-10-28":"Cumhuriyet Bayrami Arifesi",
  "2026-10-29":"29 Ekim Cumhuriyet Bayrami"
};



/* ====== LOGIN ====== */
const LoginPage = ({onLogin}) => {
  const [sel, setSel] = useState(null);
  const roles = [
    {id:"yonetici",label:"Yonetici",icon:"lock",desc:"Tum erisim, personel ve envanter yonetimi",color:C.greenDark},
    {id:"personel",label:"Personel",icon:"clipboard",desc:"Is takibi, takvim, soru gonderme",color:C.terra},
    {id:"kursiyer",label:"Kursiyer",icon:"person",desc:"Egitim takvimi, parsel bilgisi, bildirimler",color:C.sky},
  ];
  return (
    <div style={{minHeight:"100vh",background:"linear-gradient(135deg,"+C.greenDeep+" 0%,"+C.greenDark+" 50%,"+C.terra+" 100%)",display:"flex",alignItems:"center",justifyContent:"center",fontFamily:"'DM Sans',sans-serif"}}>
      <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
      <style>{"@keyframes fadeUp{from{opacity:0;transform:translateY(16px)}to{opacity:1;transform:translateY(0)}}"}</style>
      <div style={{background:"rgba(255,255,255,0.07)",backdropFilter:"blur(20px)",borderRadius:30,padding:"44px 36px",maxWidth:420,width:"92%",border:"1px solid rgba(255,255,255,0.1)",animation:"fadeUp 0.6s ease"}}>
        <div style={{textAlign:"center",marginBottom:32}}>
          <div style={{fontSize:44,marginBottom:6}}>&#127807;</div>
          <h1 style={{color:"#fff",fontSize:26,fontWeight:800,margin:0}}>Kent Bostanlari</h1>
          <p style={{color:"rgba(255,255,255,0.5)",fontSize:13,margin:"6px 0 0"}}>Cankaya Belediyesi Yonetim Sistemi</p>
        </div>
        <div style={{display:"grid",gap:10}}>
          {roles.map(function(r) { return (
            <button key={r.id} onClick={function(){setSel(r.id);}} style={{display:"flex",alignItems:"center",gap:14,padding:"16px 18px",borderRadius:16,border:sel===r.id ? "2px solid "+r.color : "2px solid rgba(255,255,255,0.1)",background:sel===r.id ? r.color+"20" : "rgba(255,255,255,0.04)",cursor:"pointer",textAlign:"left",transition:"all 0.2s"}}>
              <div style={{width:44,height:44,borderRadius:13,background:r.color+"30",display:"flex",alignItems:"center",justifyContent:"center"}}><Icon name={r.icon} size={20} color={sel===r.id ? "#fff" : "rgba(255,255,255,0.6)"}/></div>
              <div><div style={{fontSize:15,fontWeight:700,color:"#fff"}}>{r.label}</div><div style={{fontSize:11,color:"rgba(255,255,255,0.5)",marginTop:1}}>{r.desc}</div></div>
            </button>
          ); })}
        </div>
        <button onClick={function(){ if(sel) onLogin(sel); }} disabled={!sel} style={{width:"100%",marginTop:20,padding:"14px",borderRadius:14,border:"none",background:sel ? "linear-gradient(135deg,"+C.green1+","+C.greenDark+")" : "rgba(255,255,255,0.1)",color:sel ? "#fff" : "rgba(255,255,255,0.3)",fontSize:15,fontWeight:800,cursor:sel ? "pointer" : "not-allowed",transition:"all 0.2s"}}>Giris Yap</button>
      </div>
    </div>
  );
};

/* ====== CALENDAR ====== */
const Calendar = ({events, rol, onAdd, bostan}) => {
  const [curDate, setCurDate] = useState(new Date());
  const [showAdd, setShowAdd] = useState(false);
  const [nE, setNE] = useState({baslik:"",tarih:"",saat:"09:00",tip:"gorev",bildirim:false});
  const [selDay, setSelDay] = useState(null);
  var yr = curDate.getFullYear();
  var mo = curDate.getMonth();
  var aylar = ["Ocak","Subat","Mart","Nisan","Mayis","Haziran","Temmuz","Agustos","Eylul","Ekim","Kasim","Aralik"];
  var gunH = ["Pzt","Sal","Car","Per","Cum","Cmt","Paz"];
  var fd = (new Date(yr, mo, 1).getDay() + 6) % 7;
  var dim = new Date(yr, mo+1, 0).getDate();
  var days = [];
  for (var i = 0; i < fd; i++) days.push(null);
  for (var j = 1; j <= dim; j++) days.push(j);
  var canAdd = rol === "yonetici" || rol === "personel";
  var tipC = {egitim: C.sky, ekim: "#66BB6A", dikim: C.amber, besleme: "#AB47BC", gorev: C.terra, etkinlik: C.green1, tatil: C.coral};
  var fE = events.filter(function(e) { return e.tip === "egitim" || !bostan || bostan === "hepsi" || e.bostan === bostan; });
  var dayEvts = function(d) {
    var ds = yr + "-" + String(mo+1).padStart(2,"0") + "-" + String(d).padStart(2,"0");
    var evts = fE.filter(function(e) { return e.tarih === ds; });
    if (TATILLER[ds]) {
      evts = [{id:"t-"+ds, tarih:ds, saat:"", baslik:TATILLER[ds], tip:"tatil", bostan:"", bildirim:false}].concat(evts);
    }
    return evts;
  };
  var doAdd = function() {
    if (nE.baslik && nE.tarih) {
      onAdd({baslik:nE.baslik, tarih:nE.tarih, saat:nE.saat, tip:nE.tip, bildirim:nE.bildirim, id:Date.now(), bostan:bostan || "mutlukent"});
      setNE({baslik:"",tarih:"",saat:"09:00",tip:"gorev",bildirim:false});
      setShowAdd(false);
    }
  };
  var selDayEvents = selDay ? dayEvts(selDay) : [];
  return (
    <div style={{background:C.card,borderRadius:18,border:"1px solid "+C.borderLight,overflow:"hidden",boxShadow:"0 1px 3px rgba(0,0,0,0.03)"}}>
      <div style={{padding:"16px 20px",display:"flex",justifyContent:"space-between",alignItems:"center",borderBottom:"1px solid "+C.borderLight}}>
        <div style={{display:"flex",alignItems:"center",gap:10}}>
          <button onClick={function(){setCurDate(new Date(yr, mo-1, 1));}} style={{background:"none",border:"none",cursor:"pointer",fontSize:18,color:C.textSoft,padding:4}}>{"<"}</button>
          <span style={{fontSize:15,fontWeight:800,minWidth:130,textAlign:"center"}}>{aylar[mo]} {yr}</span>
          <button onClick={function(){setCurDate(new Date(yr, mo+1, 1));}} style={{background:"none",border:"none",cursor:"pointer",fontSize:18,color:C.textSoft,padding:4}}>{">"}</button>
        </div>
        {canAdd && <Btn small primary icon="plus" onClick={function(){setShowAdd(!showAdd);}}>Ekle</Btn>}
      </div>
      {showAdd && (
        <div style={{padding:16,background:C.green5,borderBottom:"1px solid "+C.green4}}>
          <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(140px,1fr))",gap:8}}>
            <div><label style={{fontSize:10,fontWeight:700,color:C.greenDark}}>Baslik</label><input value={nE.baslik} onChange={function(e){setNE({baslik:e.target.value,tarih:nE.tarih,saat:nE.saat,tip:nE.tip,bildirim:nE.bildirim});}} style={{width:"100%",padding:"7px 10px",borderRadius:8,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.greenDark}}>Tarih</label><input type="date" value={nE.tarih} onChange={function(e){setNE({baslik:nE.baslik,tarih:e.target.value,saat:nE.saat,tip:nE.tip,bildirim:nE.bildirim});}} style={{width:"100%",padding:"7px 10px",borderRadius:8,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.greenDark}}>Saat</label><input type="time" value={nE.saat} onChange={function(e){setNE({baslik:nE.baslik,tarih:nE.tarih,saat:e.target.value,tip:nE.tip,bildirim:nE.bildirim});}} style={{width:"100%",padding:"7px 10px",borderRadius:8,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.greenDark}}>Tur</label><select value={nE.tip} onChange={function(e){setNE({baslik:nE.baslik,tarih:nE.tarih,saat:nE.saat,tip:e.target.value,bildirim:nE.bildirim});}} style={{width:"100%",padding:"7px 10px",borderRadius:8,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",background:"#fff"}}><option value="egitim">Egitim</option><option value="ekim">Ekim</option><option value="dikim">Dikim/Sasirtma</option><option value="besleme">Besleme</option><option value="gorev">Gorev</option><option value="etkinlik">Etkinlik</option></select></div>
          </div>
          {rol === "yonetici" && <label style={{display:"flex",alignItems:"center",gap:6,marginTop:10,fontSize:12,color:C.greenDark,fontWeight:600,cursor:"pointer"}}><input type="checkbox" checked={nE.bildirim} onChange={function(e){setNE({baslik:nE.baslik,tarih:nE.tarih,saat:nE.saat,tip:nE.tip,bildirim:e.target.checked});}} style={{accentColor:C.green1}}/>Kursiyerlere bildirim gonder</label>}
          <div style={{display:"flex",gap:6,marginTop:10}}><Btn small primary onClick={doAdd}>Kaydet</Btn><Btn small onClick={function(){setShowAdd(false);}}>Iptal</Btn></div>
        </div>
      )}
      <div style={{display:"flex",gap:6,padding:"6px 14px",flexWrap:"wrap",borderBottom:"1px solid "+C.borderLight,alignItems:"center"}}>
        <span style={{display:"inline-flex",alignItems:"center",gap:3,fontSize:9,fontWeight:700,color:"#4CAF50"}}><span style={{width:6,height:6,borderRadius:"50%",background:"#4CAF50",display:"inline-block"}}/>M Egitim</span>
        <span style={{display:"inline-flex",alignItems:"center",gap:3,fontSize:9,fontWeight:700,color:"#2196F3"}}><span style={{width:6,height:6,borderRadius:"50%",background:"#2196F3",display:"inline-block"}}/>A Egitim</span>
        <span style={{fontSize:9,color:C.border}}>|</span>
        <span style={{display:"inline-flex",alignItems:"center",gap:3,fontSize:9,fontWeight:600,color:"#66BB6A"}}><span style={{width:6,height:6,borderRadius:"50%",background:"#66BB6A",display:"inline-block"}}/>Ekim</span>
        <span style={{display:"inline-flex",alignItems:"center",gap:3,fontSize:9,fontWeight:600,color:C.amber}}><span style={{width:6,height:6,borderRadius:"50%",background:C.amber,display:"inline-block"}}/>Dikim</span>
        <span style={{display:"inline-flex",alignItems:"center",gap:3,fontSize:9,fontWeight:600,color:"#AB47BC"}}><span style={{width:6,height:6,borderRadius:"50%",background:"#AB47BC",display:"inline-block"}}/>Besleme</span>
        <span style={{fontSize:9,color:C.border}}>|</span>
        <span style={{display:"inline-flex",alignItems:"center",gap:3,fontSize:9,fontWeight:700,color:C.coral}}><span style={{width:6,height:6,borderRadius:"50%",background:C.coral,display:"inline-block"}}/>Tatil</span>
      </div>
      <div style={{display:"grid",gridTemplateColumns:"repeat(7,1fr)",padding:"4px 10px 10px",gap:2}}>
        {gunH.map(function(g) { return <div key={"h"+g} style={{textAlign:"center",fontSize:10,fontWeight:700,color:C.textMuted,padding:"4px 0"}}>{g}</div>; })}
        {days.map(function(day, idx) {
          if (!day) return <div key={"d"+idx}/>;
          var ev = dayEvts(day);
          var today = new Date(); var isT = day === today.getDate() && mo === today.getMonth() && yr === today.getFullYear();
              var dStr = yr + "-" + String(mo+1).padStart(2,"0") + "-" + String(day).padStart(2,"0");
              var isTatil = !!TATILLER[dStr];
          var maxShow = ev.length <= 4 ? ev.length : 3;
          return (
            <div key={"d"+idx} onClick={function(){setSelDay(selDay === day ? null : day);}} style={{minHeight:48,padding:2,borderRadius:7,cursor:"pointer",background:isTatil ? C.coral+"10" : isT ? C.green1+"12" : "transparent",border:isT ? "2px solid "+C.green1 : selDay === day ? "2px solid "+C.sky : "2px solid transparent",overflow:"hidden"}}>
              <div style={{fontSize:11,fontWeight:isT ? 800 : isTatil ? 700 : 600,color:isT ? C.green1 : isTatil ? C.coral : C.text,textAlign:"center",marginBottom:1}}>{day}</div>
              {ev.slice(0,maxShow).map(function(e) {
                var bRenk = BOSTANLAR[e.bostan] ? BOSTANLAR[e.bostan].renk : tipC[e.tip];
                var eColor = e.tip === "egitim" ? bRenk : tipC[e.tip];
                var prefix = e.tip === "egitim" ? (e.bostan === "mutlukent" ? "M " : "A ") : "";
                return <div key={e.id} style={{fontSize:7,lineHeight:"10px",padding:"1px 2px",borderRadius:2,marginBottom:1,background:eColor+"20",color:eColor,fontWeight:700,overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{prefix}{e.baslik}</div>;
              })}
              {ev.length > maxShow && <div style={{fontSize:7,color:C.textMuted,textAlign:"center",lineHeight:"9px"}}>+{ev.length - maxShow}</div>}
            </div>
          );
        })}
      </div>
      {selDay && selDayEvents.length > 0 && (
        <div style={{padding:"12px 18px",borderTop:"1px solid "+C.borderLight,background:C.bgWarm}}>
          <div style={{fontSize:12,fontWeight:700,marginBottom:6}}>{selDay} {aylar[mo]} Etkinlikleri</div>
          {selDayEvents.map(function(e) {
            var bRenk = BOSTANLAR[e.bostan] ? BOSTANLAR[e.bostan].renk : C.textMuted;
            var dotColor = e.tip === "egitim" ? bRenk : tipC[e.tip];
            var bostanAd = BOSTANLAR[e.bostan] ? BOSTANLAR[e.bostan].kisa : "";
            var tipAd = {egitim:"Egitim",ekim:"Ekim",dikim:"Dikim",besleme:"Besleme",gorev:"Gorev",etkinlik:"Etkinlik",tatil:"Tatil"}[e.tip] || e.tip;
            return (
            <div key={e.id} style={{display:"flex",alignItems:"center",gap:8,padding:"6px 0",borderBottom:"1px solid "+C.borderLight}}>
              <div style={{width:8,height:8,borderRadius:"50%",background:dotColor,flexShrink:0}}/>
              <div style={{flex:1}}>
                <div style={{fontSize:12,fontWeight:600}}>{e.baslik}</div>
                <div style={{fontSize:10,color:C.textMuted}}>{e.saat} - {tipAd}</div>
              </div>
              <Badge color={bRenk}>{bostanAd}</Badge>
            </div>
          ); })}
        </div>
      )}
    </div>
  );
};

/* ====== BOSTAN SELECTOR ====== */
const BostanSel = ({sel, onSel}) => (
  <div style={{display:"flex",gap:12,marginBottom:22,flexWrap:"wrap"}}>
    {Object.entries(BOSTANLAR).map(function(entry) { var k=entry[0]; var b=entry[1]; return (
      <button key={k} onClick={function(){onSel(k);}} style={{flex:"1 1 200px",padding:"18px 22px",borderRadius:20,border:sel===k ? "3px solid "+b.renk : "3px solid transparent",background:sel===k ? "linear-gradient(135deg,"+b.renk+"12,"+b.renk+"04)" : C.card,cursor:"pointer",textAlign:"left",boxShadow:sel===k ? "0 4px 18px "+b.renk+"18" : "0 1px 3px rgba(0,0,0,0.03)",transition:"all 0.25s"}}>
        <div style={{display:"flex",alignItems:"center",gap:12}}>
          <div style={{fontSize:32}}>{b.emoji}</div>
          <div>
            <div style={{fontSize:16,fontWeight:800,color:C.text}}>{b.ad}</div>
            <div style={{fontSize:11,color:C.textSoft,marginTop:2}}>{b.kursiyerler.length} kursiyer - {b.parseller.filter(function(p){return p.durum==="Dolu";}).length} parsel - {b.envanter.length} malzeme</div>
          </div>
        </div>
      </button>
    ); })}
  </div>
);

/* ====== DASHBOARD ====== */
const Dash = ({bostan, events, onAdd, rol}) => {
  var b = BOSTANLAR[bostan];
  var lowStock = b.envanter.filter(function(e){return e.stok<=e.min;});
  return (
    <div>
      <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(190px,1fr))",gap:12,marginBottom:20}}>
        <StatCard icon="users" label="Kursiyer" value={b.kursiyerler.length} sub={b.kursiyerler.filter(function(k){return k.durum==="Aktif";}).length + " aktif"} color={C.green1}/>
        <StatCard icon="grid" label="Parsel" value={b.parseller.length} sub={b.parseller.filter(function(p){return p.durum==="Dolu";}).length + " dolu"} color={C.terra} delay={0.05}/>
        <StatCard icon="box" label="Envanter" value={b.envanter.length} sub={lowStock.length > 0 ? lowStock.length + " dusuk stok" : "Yeterli"} color={C.amber} delay={0.1}/>
        <StatCard icon="clipboard" label="Gorev" value={b.gorevler.length} sub={b.gorevler.filter(function(g){return g.durum==="Bekliyor";}).length + " bekliyor"} color={C.sky} delay={0.15}/>
      </div>
      <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(320px,1fr))",gap:16}}>
        <Calendar events={events} rol={rol} onAdd={onAdd} bostan={bostan}/>
        <div style={{display:"grid",gap:16}}>
          <div style={{background:"linear-gradient(145deg,"+b.renk+","+C.greenDark+")",borderRadius:18,padding:22,color:"#fff"}}>
            <div style={{display:"flex",alignItems:"center",gap:6,marginBottom:10}}><Icon name="sun" size={18} color="#FFD54F"/><span style={{fontSize:12,opacity:0.8}}>Bugun - Ankara</span></div>
            <div style={{fontSize:38,fontWeight:800}}>18 C</div>
            <div style={{fontSize:12,opacity:0.65,marginBottom:14}}>Parcali bulutlu - Ruzgar 12 km/s</div>
            <div style={{background:"rgba(255,255,255,0.12)",borderRadius:11,padding:12,fontSize:12,lineHeight:1.5}}>Sulama icin ideal. Aksam serin - hassas fideleri ortun.</div>
          </div>
        </div>
      </div>
    </div>
  );
};

/* ====== PAGES ====== */
const Kursiyerler = ({bostan, rol, onSil}) => {
  var b = BOSTANLAR[bostan];
  const [s, setS] = useState("");
  const [silId, setSilId] = useState(null);
  var f = b.kursiyerler.filter(function(k) { return k.ad.toLowerCase().indexOf(s.toLowerCase()) >= 0; });
  var doSil = function() {
    if (silId !== null) { onSil(bostan, silId); setSilId(null); }
  };
  var silAd = silId !== null ? (b.kursiyerler.filter(function(k){return k.id===silId;})[0] || {}).ad || "" : "";
  return (
    <div>
      <div style={{display:"flex",gap:8,marginBottom:14,flexWrap:"wrap",alignItems:"center"}}>
        <div style={{display:"flex",alignItems:"center",gap:6,background:C.card,border:"1px solid "+C.border,borderRadius:10,padding:"7px 12px",flex:"1 1 180px",maxWidth:300}}><Icon name="search" size={14} color={C.textMuted}/><input placeholder="Ara..." value={s} onChange={function(e){setS(e.target.value);}} style={{border:"none",outline:"none",background:"transparent",fontSize:12,width:"100%",fontFamily:"inherit"}}/></div>
        {rol === "yonetici" && <Btn primary small icon="plus">Yeni Kursiyer</Btn>}
      </div>
      <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.borderLight,overflow:"hidden"}}>
        <div style={{overflowX:"auto"}}>
          <table style={{width:"100%",borderCollapse:"collapse",fontSize:13}}>
            <thead><tr style={{background:C.green5}}>{(rol==="yonetici" ? ["Ad","Tel","Parsel","Kurs","Durum","Kayit",""] : ["Ad","Tel","Parsel","Kurs","Durum","Kayit"]).map(function(h){return <th key={h||"act"} style={{padding:"10px 12px",textAlign:"left",fontWeight:700,fontSize:11,color:C.greenDark}}>{h}</th>;})}</tr></thead>
            <tbody>{f.map(function(k) { return (
              <tr key={k.id} style={{borderBottom:"1px solid "+C.borderLight}}>
                <td style={{padding:"10px 12px",fontWeight:700}}>{k.ad}</td>
                <td style={{padding:"10px 12px"}}>{k.tel}</td>
                <td style={{padding:"10px 12px"}}>{k.parsel !== "-" ? <Badge color={C.green1}>{k.parsel}</Badge> : "-"}</td>
                <td style={{padding:"10px 12px",fontSize:11,color:C.textSoft}}>{k.kurs}</td>
                <td style={{padding:"10px 12px"}}><Badge color={k.durum==="Aktif" ? C.green1 : k.durum==="Beklemede" ? C.amber : C.textMuted}>{k.durum}</Badge></td>
                <td style={{padding:"10px 12px",fontSize:11,color:C.textMuted}}>{k.kayit}</td>
                {rol === "yonetici" && <td style={{padding:"10px 8px",textAlign:"center"}}><button onClick={function(){setSilId(k.id);}} style={{background:"none",border:"none",cursor:"pointer",padding:4,borderRadius:6,display:"flex",alignItems:"center",justifyContent:"center"}} title="Sil"><Icon name="alert" size={14} color={C.coral}/></button></td>}
              </tr>
            ); })}</tbody>
          </table>
        </div>
      </div>
      {silId !== null && (
        <div style={{position:"fixed",inset:0,background:"rgba(0,0,0,0.4)",display:"flex",alignItems:"center",justifyContent:"center",zIndex:200,backdropFilter:"blur(3px)"}}>
          <div style={{background:C.card,borderRadius:20,padding:"28px 32px",maxWidth:380,width:"90%",boxShadow:"0 20px 60px rgba(0,0,0,0.2)",animation:"fadeUp 0.3s ease"}}>
            <div style={{display:"flex",alignItems:"center",gap:10,marginBottom:16}}>
              <div style={{width:42,height:42,borderRadius:12,background:C.coral+"15",display:"flex",alignItems:"center",justifyContent:"center"}}><Icon name="alert" size={22} color={C.coral}/></div>
              <div><div style={{fontSize:15,fontWeight:800,color:C.text}}>Kursiyer Sil</div><div style={{fontSize:12,color:C.textMuted}}>Bu islem geri alinamaz</div></div>
            </div>
            <div style={{padding:"14px 16px",background:C.coral+"08",borderRadius:12,marginBottom:18,fontSize:13,lineHeight:1.6,color:C.text}}>
              <b>{silAd}</b> isimli kursiyeri silmek istediginize emin misiniz?
            </div>
            <div style={{display:"flex",gap:8,justifyContent:"flex-end"}}>
              <Btn small onClick={function(){setSilId(null);}}>Vazgec</Btn>
              <button onClick={doSil} style={{padding:"8px 20px",borderRadius:10,border:"none",background:"linear-gradient(135deg,"+C.coral+",#C62828)",color:"#fff",fontSize:12,fontWeight:700,cursor:"pointer",boxShadow:"0 2px 10px "+C.coral+"40"}}>Evet, Sil</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

const Gorevler = ({bostan, rol, onEkle, onSil, onTakvimeGonder}) => {
  var b = BOSTANLAR[bostan];
  const [fil, setFil] = useState("Tumu");
  const [showAdd, setShowAdd] = useState(false);
  const [silId, setSilId] = useState(null);
  const [takvimModal, setTakvimModal] = useState(null);
  const [takvimTarih, setTakvimTarih] = useState(new Date().toISOString().slice(0,10));
  const [takvimSaat, setTakvimSaat] = useState("09:00");
  const [gonderildi, setGonderildi] = useState({});
  const [nG, setNG] = useState({baslik:"",atanan:"",oncelik:"Orta",tarih:""});
  var fl = fil === "Tumu" ? b.gorevler : b.gorevler.filter(function(g) { return g.durum === fil; });
  var doAdd = function() {
    if (nG.baslik.trim()) {
      onEkle(bostan, {id:Date.now(),baslik:nG.baslik,atanan:nG.atanan||"-",oncelik:nG.oncelik,durum:"Bekliyor",tarih:nG.tarih||"Bu hafta"});
      setNG({baslik:"",atanan:"",oncelik:"Orta",tarih:""});
      setShowAdd(false);
    }
  };
  var doSil = function() {
    if (silId !== null) { onSil(bostan, silId); setSilId(null); }
  };
  var silAd = silId !== null ? (b.gorevler.filter(function(g){return g.id===silId;})[0] || {}).baslik || "" : "";
  return (
    <div>
      <div style={{display:"flex",gap:6,marginBottom:14,flexWrap:"wrap"}}>
        {["Tumu","Bekliyor","Devam Ediyor","Tamamlandi"].map(function(x) { return <button key={x} onClick={function(){setFil(x);}} style={{padding:"7px 16px",borderRadius:10,border:fil===x ? "none" : "1px solid "+C.border,background:fil===x ? "linear-gradient(135deg,"+C.green1+","+C.greenDark+")" : C.card,color:fil===x ? "#fff" : C.text,fontSize:12,fontWeight:700,cursor:"pointer"}}>{x}</button>; })}
        <div style={{flex:1}}/>{rol !== "kursiyer" && <Btn primary small icon="plus" onClick={function(){setShowAdd(!showAdd);}}>Yeni</Btn>}
      </div>
      {showAdd && (
        <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.green1+"40",padding:20,marginBottom:14,animation:"fadeUp .3s ease"}}>
          <div style={{fontSize:13,fontWeight:700,marginBottom:12,color:C.greenDark}}>Yeni Gorev</div>
          <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(150px,1fr))",gap:10}}>
            <div style={{gridColumn:"1/-1"}}><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Gorev Baslik</label><input value={nG.baslik} onChange={function(e){setNG({baslik:e.target.value,atanan:nG.atanan,oncelik:nG.oncelik,tarih:nG.tarih});}} style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Atanan Kisi</label><input value={nG.atanan} onChange={function(e){setNG({baslik:nG.baslik,atanan:e.target.value,oncelik:nG.oncelik,tarih:nG.tarih});}} placeholder="Personel adi" style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Oncelik</label><select value={nG.oncelik} onChange={function(e){setNG({baslik:nG.baslik,atanan:nG.atanan,oncelik:e.target.value,tarih:nG.tarih});}} style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",background:"#fff"}}><option>Yuksek</option><option>Orta</option><option>Dusuk</option></select></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Tarih</label><input type="date" value={nG.tarih} onChange={function(e){setNG({baslik:nG.baslik,atanan:nG.atanan,oncelik:nG.oncelik,tarih:e.target.value});}} style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
          </div>
          <div style={{display:"flex",gap:8,marginTop:14}}>
            <Btn small primary onClick={doAdd}>Kaydet</Btn>
            <Btn small onClick={function(){setShowAdd(false);setNG({baslik:"",atanan:"",oncelik:"Orta",tarih:""});}}>Vazgec</Btn>
          </div>
        </div>
      )}
      <div style={{display:"grid",gap:8}}>
        {fl.map(function(g, i) { return (
          <div key={g.id} style={{background:C.card,borderRadius:14,border:"1px solid "+C.borderLight,padding:"12px 18px",display:"flex",alignItems:"center",gap:12,borderLeft:"4px solid "+(g.oncelik==="Yuksek" ? C.coral : g.oncelik==="Orta" ? C.amber : C.textMuted),animation:"fadeUp .4s ease "+i*0.04+"s both"}}>
            <div style={{width:26,height:26,borderRadius:7,border:"2px solid "+(g.durum==="Tamamlandi" ? C.green1 : C.border),background:g.durum==="Tamamlandi" ? C.green1 : "transparent",display:"flex",alignItems:"center",justifyContent:"center"}}>{g.durum==="Tamamlandi" && <Icon name="check" size={13} color="#fff"/>}</div>
            <div style={{flex:1}}>
              <div style={{fontSize:13,fontWeight:700,color:g.durum==="Tamamlandi" ? C.textMuted : C.text,textDecoration:g.durum==="Tamamlandi" ? "line-through" : "none"}}>{g.baslik}</div>
              <div style={{fontSize:11,color:C.textMuted}}>{g.atanan} - {g.tarih}</div>
            </div>
            <Badge color={g.durum==="Tamamlandi" ? C.green1 : g.durum==="Devam Ediyor" ? C.sky : C.amber}>{g.durum}</Badge>
            {rol !== "kursiyer" && !gonderildi[g.id] && <button onClick={function(){setTakvimModal(g);setTakvimTarih(new Date().toISOString().slice(0,10));setTakvimSaat("09:00");}} style={{padding:"4px 8px",borderRadius:6,border:"1px solid "+C.sky,background:"transparent",cursor:"pointer",display:"flex",alignItems:"center",gap:3,fontSize:10,fontWeight:700,color:C.sky}} title="Takvime Gonder"><Icon name="calendar" size={12} color={C.sky}/></button>}
            {gonderildi[g.id] && <span style={{fontSize:9,color:C.green1,fontWeight:700}}>Takvimde</span>}
            {rol !== "kursiyer" && <button onClick={function(){setSilId(g.id);}} style={{background:"none",border:"none",cursor:"pointer",padding:4,borderRadius:6}} title="Sil"><Icon name="alert" size={14} color={C.coral}/></button>}
          </div>
        ); })}
      </div>
      {takvimModal && (
        <div style={{position:"fixed",inset:0,background:"rgba(0,0,0,0.4)",display:"flex",alignItems:"center",justifyContent:"center",zIndex:200,backdropFilter:"blur(3px)"}}>
          <div style={{background:C.card,borderRadius:20,padding:"28px 32px",maxWidth:400,width:"90%",boxShadow:"0 20px 60px rgba(0,0,0,0.2)",animation:"fadeUp 0.3s ease"}}>
            <div style={{display:"flex",alignItems:"center",gap:10,marginBottom:18}}>
              <div style={{width:42,height:42,borderRadius:12,background:C.sky+"15",display:"flex",alignItems:"center",justifyContent:"center"}}><Icon name="calendar" size={22} color={C.sky}/></div>
              <div>
                <div style={{fontSize:15,fontWeight:800,color:C.text}}>Takvime Gonder</div>
                <div style={{fontSize:12,color:C.textMuted}}>{takvimModal.baslik}</div>
              </div>
            </div>
            <div style={{display:"grid",gap:12}}>
              <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Tarih</label><input type="date" value={takvimTarih} onChange={function(e){setTakvimTarih(e.target.value);}} style={{width:"100%",padding:"9px 14px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
              <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Saat</label><input type="time" value={takvimSaat} onChange={function(e){setTakvimSaat(e.target.value);}} style={{width:"100%",padding:"9px 14px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
            </div>
            <div style={{display:"flex",gap:8,justifyContent:"flex-end",marginTop:18}}>
              <Btn small onClick={function(){setTakvimModal(null);}}>Vazgec</Btn>
              <button onClick={function(){onTakvimeGonder(bostan, takvimModal.baslik, takvimTarih, takvimSaat); var ng = {}; ng[takvimModal.id] = true; setGonderildi(Object.assign({}, gonderildi, ng)); setTakvimModal(null);}} style={{padding:"8px 20px",borderRadius:10,border:"none",background:"linear-gradient(135deg,"+C.sky+",#0288D1)",color:"#fff",fontSize:12,fontWeight:700,cursor:"pointer",boxShadow:"0 2px 10px "+C.sky+"40"}}>Gonder</button>
            </div>
          </div>
        </div>
      )}
      {silId !== null && (
        <div style={{position:"fixed",inset:0,background:"rgba(0,0,0,0.4)",display:"flex",alignItems:"center",justifyContent:"center",zIndex:200,backdropFilter:"blur(3px)"}}>
          <div style={{background:C.card,borderRadius:20,padding:"28px 32px",maxWidth:400,width:"90%",boxShadow:"0 20px 60px rgba(0,0,0,0.2)",animation:"fadeUp 0.3s ease"}}>
            <div style={{display:"flex",alignItems:"center",gap:10,marginBottom:16}}>
              <div style={{width:42,height:42,borderRadius:12,background:C.coral+"15",display:"flex",alignItems:"center",justifyContent:"center"}}><Icon name="alert" size={22} color={C.coral}/></div>
              <div><div style={{fontSize:15,fontWeight:800,color:C.text}}>Gorev Sil</div><div style={{fontSize:12,color:C.textMuted}}>Bu islem geri alinamaz</div></div>
            </div>
            <div style={{padding:"14px 16px",background:C.coral+"08",borderRadius:12,marginBottom:18,fontSize:13,lineHeight:1.6,color:C.text}}>
              <b>{silAd}</b> gorevini silmek istediginize emin misiniz?
            </div>
            <div style={{display:"flex",gap:8,justifyContent:"flex-end"}}>
              <Btn small onClick={function(){setSilId(null);}}>Vazgec</Btn>
              <button onClick={doSil} style={{padding:"8px 20px",borderRadius:10,border:"none",background:"linear-gradient(135deg,"+C.coral+",#C62828)",color:"#fff",fontSize:12,fontWeight:700,cursor:"pointer",boxShadow:"0 2px 10px "+C.coral+"40"}}>Evet, Sil</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

const Parseller = ({bostan, rol, onUrunGuncelle}) => {
  var b = BOSTANLAR[bostan];
  const [selP, setSelP] = useState(null);
  const [yeniUrun, setYeniUrun] = useState("");
  var secili = selP !== null ? b.parseller.filter(function(p){return p.id===selP;})[0] : null;
  var urunler = secili && secili.urun && secili.urun !== "-" ? secili.urun.split(", ").filter(function(u){return u.trim();}) : [];
  var doEkle = function() {
    if (yeniUrun.trim() && selP !== null) {
      var yeni = urunler.concat([yeniUrun.trim()]).join(", ");
      onUrunGuncelle(bostan, selP, yeni);
      setYeniUrun("");
    }
  };
  var doSil = function(idx) {
    if (selP !== null) {
      var yeni = urunler.filter(function(u, i){return i !== idx;});
      onUrunGuncelle(bostan, selP, yeni.length > 0 ? yeni.join(", ") : "-");
    }
  };
  return (
    <div>
      <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fill,minmax(220px,1fr))",gap:12}}>
        {b.parseller.map(function(p, i) {
          var dc = p.durum==="Dolu" ? C.green1 : p.durum==="Bos" ? C.textMuted : C.amber;
          var isSel = selP === p.id;
          return (
            <div key={p.id} onClick={function(){setSelP(isSel ? null : p.id);setYeniUrun("");}} style={{background:C.card,borderRadius:16,border:isSel ? "2px solid "+C.green1 : "1px solid "+C.borderLight,padding:18,position:"relative",cursor:"pointer",animation:"fadeUp .4s ease "+i*0.04+"s both",boxShadow:isSel ? "0 4px 16px "+C.green1+"20" : "none"}}>
              <div style={{position:"absolute",top:0,right:0,padding:"5px 12px",borderRadius:"0 16px 0 12px",fontSize:10,fontWeight:800,background:dc+"14",color:dc}}>{p.durum}</div>
              <div style={{fontSize:20,fontWeight:900,color:C.green1,marginBottom:10,fontFamily:"monospace"}}>{p.id}</div>
              <div style={{display:"grid",gap:4,fontSize:12}}>
                <div><span style={{color:C.textMuted}}>Kursiyer:</span> <b>{p.kursiyer}</b></div>
                <div><span style={{color:C.textMuted}}>Urun:</span> <b>{p.urun}</b></div>
                <div><span style={{color:C.textMuted}}>Ekim:</span> <b>{p.ekim}</b></div>
              </div>
            </div>
          );
        })}
      </div>
      {secili && (rol === "yonetici" || rol === "personel") && (
        <div style={{marginTop:16,background:C.card,borderRadius:18,border:"1px solid "+C.green1+"40",padding:22,animation:"fadeUp .3s ease"}}>
          <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:14}}>
            <div style={{fontSize:14,fontWeight:800}}>Parsel {secili.id} - Urun Yonetimi</div>
            <button onClick={function(){setSelP(null);}} style={{background:"none",border:"none",cursor:"pointer",fontSize:18,color:C.textMuted,padding:4}}>x</button>
          </div>
          <div style={{display:"flex",gap:8,flexWrap:"wrap",marginBottom:14}}>
            {urunler.length === 0 && <span style={{fontSize:12,color:C.textMuted,fontStyle:"italic"}}>Henuz urun eklenmemis</span>}
            {urunler.map(function(u, idx) {
              return (
                <div key={idx} style={{display:"inline-flex",alignItems:"center",gap:6,padding:"6px 10px 6px 14px",borderRadius:20,background:C.green1+"12",border:"1px solid "+C.green1+"30",fontSize:12,fontWeight:700,color:C.greenDark}}>
                  {u}
                  <button onClick={function(e){e.stopPropagation();doSil(idx);}} style={{background:C.coral+"18",border:"none",cursor:"pointer",width:20,height:20,borderRadius:"50%",display:"flex",alignItems:"center",justifyContent:"center",fontSize:12,fontWeight:700,color:C.coral,lineHeight:1}}>x</button>
                </div>
              );
            })}
          </div>
          <div style={{display:"flex",gap:8}}>
            <input value={yeniUrun} onChange={function(e){setYeniUrun(e.target.value);}} onKeyDown={function(e){if(e.key==="Enter"){doEkle();}}} placeholder="Cesit adi (orn: Domates, Biber...)" style={{flex:1,padding:"9px 14px",borderRadius:10,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",outline:"none"}}/>
            <Btn small primary onClick={doEkle}>Ekle</Btn>
          </div>
        </div>
      )}
    </div>
  );
};

const Envanter = ({bostan, rol, onSil, onEkle, onStokGuncelle, stokLog}) => {
  var b = BOSTANLAR[bostan];
  const [kf, setKf] = useState("Tumu");
  const [silId, setSilId] = useState(null);
  const [showAdd, setShowAdd] = useState(false);
  const [stokModal, setStokModal] = useState(null);
  const [stokMiktar, setStokMiktar] = useState("1");
  const [stokTarih, setStokTarih] = useState(new Date().toISOString().slice(0,10));
  const [stokNeden, setStokNeden] = useState("Kullanim");
  const [stokNot, setStokNot] = useState("");
  const [showLog, setShowLog] = useState(null);
  const [nE, setNE] = useState({ad:"",kat:"Tohum",stok:"",min:"",birim:"pkt",fiyat:0,konum:"Depo A"});
  var fl = b.envanter.filter(function(e) { return kf === "Tumu" || e.kat === kf; });
  var ds = b.envanter.filter(function(e) { return e.stok <= e.min; });
  var doSil = function() {
    if (silId !== null) { onSil(bostan, silId); setSilId(null); }
  };
  var doAdd = function() {
    if (nE.ad.trim() && nE.stok) {
      onEkle(bostan, {id:Date.now(),ad:nE.ad,kat:nE.kat,stok:parseInt(nE.stok)||0,min:parseInt(nE.min)||5,birim:nE.birim,fiyat:0,konum:nE.konum});
      setNE({ad:"",kat:"Tohum",stok:"",min:"",birim:"pkt",fiyat:0,konum:"Depo A"});
      setShowAdd(false);
    }
  };
  var doStokIslem = function() {
    var m = parseInt(stokMiktar);
    if (!stokModal || isNaN(m) || m <= 0) return;
    var item = b.envanter.filter(function(e){return e.id===stokModal.id;})[0];
    if (!item) return;
    var yeniStok = stokModal.tip === "eksilt" ? Math.max(0, item.stok - m) : item.stok + m;
    onStokGuncelle(bostan, item.id, yeniStok, {tarih:stokTarih, miktar:m, tip:stokModal.tip, neden:stokNeden, not:stokNot, ad:item.ad, birim:item.birim});
    setStokModal(null); setStokMiktar("1"); setStokNeden("Kullanim"); setStokNot("");
  };
  var silAd = silId !== null ? (b.envanter.filter(function(e){return e.id===silId;})[0] || {}).ad || "" : "";
  var modalItem = stokModal ? b.envanter.filter(function(e){return e.id===stokModal.id;})[0] : null;
  var logItem = showLog !== null ? (stokLog||[]).filter(function(l){return l.envId===showLog && l.bostan===bostan;}) : [];
  var logAd = showLog !== null ? (b.envanter.filter(function(e){return e.id===showLog;})[0]||{}).ad||"" : "";
  return (
    <div>
      {ds.length > 0 && (
        <div style={{background:C.coral+"08",border:"1px solid "+C.coral+"25",borderRadius:14,padding:"12px 16px",marginBottom:16,display:"flex",alignItems:"center",gap:10}}>
          <Icon name="alert" size={18} color={C.coral}/>
          <div><div style={{fontSize:12,fontWeight:700,color:C.coral}}>Dusuk Stok!</div><div style={{fontSize:11,color:C.textSoft}}>{ds.map(function(e){return e.ad;}).join(", ")}</div></div>
        </div>
      )}
      <div style={{display:"flex",gap:6,marginBottom:14,flexWrap:"wrap"}}>
        {["Tumu","Tohum","Gubre","Alet"].map(function(ft) { return <button key={ft} onClick={function(){setKf(ft);}} style={{padding:"7px 16px",borderRadius:10,border:kf===ft ? "none" : "1px solid "+C.border,background:kf===ft ? "linear-gradient(135deg,"+C.green1+","+C.greenDark+")" : C.card,color:kf===ft ? "#fff" : C.text,fontSize:12,fontWeight:700,cursor:"pointer"}}>{ft}</button>; })}
        <div style={{flex:1}}/>{rol !== "kursiyer" && <Btn primary small icon="plus" onClick={function(){setShowAdd(!showAdd);}}>Ekle</Btn>}
      </div>
      {showAdd && (
        <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.green1+"40",padding:20,marginBottom:14,animation:"fadeUp .3s ease"}}>
          <div style={{fontSize:13,fontWeight:700,marginBottom:12,color:C.greenDark}}>Yeni Malzeme</div>
          <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(130px,1fr))",gap:10}}>
            <div style={{gridColumn:"1/-1"}}><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Malzeme Adi</label><input value={nE.ad} onChange={function(e){setNE({ad:e.target.value,kat:nE.kat,stok:nE.stok,min:nE.min,birim:nE.birim,fiyat:nE.fiyat,konum:nE.konum});}} style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Kategori</label><select value={nE.kat} onChange={function(e){setNE({ad:nE.ad,kat:e.target.value,stok:nE.stok,min:nE.min,birim:nE.birim,fiyat:nE.fiyat,konum:nE.konum});}} style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",background:"#fff"}}><option>Tohum</option><option>Gubre</option><option>Alet</option></select></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Stok</label><input type="number" value={nE.stok} onChange={function(e){setNE({ad:nE.ad,kat:nE.kat,stok:e.target.value,min:nE.min,birim:nE.birim,fiyat:nE.fiyat,konum:nE.konum});}} style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Min. Stok</label><input type="number" value={nE.min} onChange={function(e){setNE({ad:nE.ad,kat:nE.kat,stok:nE.stok,min:e.target.value,birim:nE.birim,fiyat:nE.fiyat,konum:nE.konum});}} style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Birim</label><select value={nE.birim} onChange={function(e){setNE({ad:nE.ad,kat:nE.kat,stok:nE.stok,min:nE.min,birim:e.target.value,fiyat:0,konum:nE.konum});}} style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",background:"#fff"}}><option>pkt</option><option>kg</option><option>adet</option><option>lt</option></select></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Konum</label><select value={nE.konum} onChange={function(e){setNE({ad:nE.ad,kat:nE.kat,stok:nE.stok,min:nE.min,birim:nE.birim,fiyat:0,konum:e.target.value});}} style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",background:"#fff"}}><option>Depo A</option><option>Depo B</option><option>Atolye</option></select></div>
          </div>
          <div style={{display:"flex",gap:8,marginTop:14}}>
            <Btn small primary onClick={doAdd}>Kaydet</Btn>
            <Btn small onClick={function(){setShowAdd(false);setNE({ad:"",kat:"Tohum",stok:"",min:"",birim:"pkt",fiyat:"",konum:"Depo A"});}}>Vazgec</Btn>
          </div>
        </div>
      )}
      <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.borderLight,overflow:"hidden"}}>
        <div style={{overflowX:"auto"}}>
          <table style={{width:"100%",borderCollapse:"collapse",fontSize:13}}>
            <thead><tr style={{background:C.green5}}>{(rol !== "kursiyer" ? ["Malzeme","Kat.","Stok","Min","Konum","Durum",""] : ["Malzeme","Kat.","Stok","Min","Konum","Durum"]).map(function(h){return <th key={h||"act"} style={{padding:"10px 12px",textAlign:"left",fontWeight:700,fontSize:11,color:C.greenDark}}>{h}</th>;})}</tr></thead>
            <tbody>{fl.map(function(e) {
              var k = e.stok <= e.min;
              return (
                <tr key={e.id} style={{borderBottom:"1px solid "+C.borderLight,background:k ? C.coral+"04" : ""}}>
                  <td style={{padding:"10px 12px",fontWeight:700}}>{e.ad}</td>
                  <td style={{padding:"10px 12px"}}><Badge color={e.kat==="Tohum" ? C.green1 : e.kat==="Gubre" ? C.terra : C.sky}>{e.kat}</Badge></td>
                  <td style={{padding:"6px 10px",fontWeight:700,color:k ? C.coral : C.text}}>
                    {rol !== "kursiyer" ? (
                      <div style={{display:"flex",alignItems:"center",gap:3}}>
                        <button onClick={function(){setStokModal({id:e.id,tip:"eksilt"});setStokMiktar("1");setStokTarih(new Date().toISOString().slice(0,10));setStokNeden("Kullanim");setStokNot("");}} style={{width:22,height:22,borderRadius:6,border:"1px solid "+(e.stok>0?C.coral+"60":C.border),background:e.stok>0?C.coral+"08":"transparent",cursor:e.stok>0?"pointer":"default",display:"flex",alignItems:"center",justifyContent:"center",fontSize:14,fontWeight:700,color:e.stok>0?C.coral:C.border,lineHeight:1}}>-</button>
                        <span onClick={function(){setShowLog(showLog===e.id?null:e.id);}} style={{cursor:"pointer",minWidth:26,textAlign:"center",fontSize:13,textDecoration:"underline",textDecorationStyle:"dotted",textUnderlineOffset:3}}>{e.stok}</span>
                        <span style={{fontSize:9,color:C.textMuted}}>{e.birim}</span>
                        <button onClick={function(){setStokModal({id:e.id,tip:"ekle"});setStokMiktar("1");setStokTarih(new Date().toISOString().slice(0,10));setStokNeden("Satin Alma");setStokNot("");}} style={{width:22,height:22,borderRadius:6,border:"1px solid "+C.green1+"60",background:C.green1+"08",cursor:"pointer",display:"flex",alignItems:"center",justifyContent:"center",fontSize:14,fontWeight:700,color:C.green1,lineHeight:1}}>+</button>
                      </div>
                    ) : (
                      <span>{e.stok} {e.birim}</span>
                    )}
                  </td>
                  <td style={{padding:"10px 12px",color:C.textMuted}}>{e.min}</td>
                  <td style={{padding:"10px 12px",fontSize:11,color:C.textSoft}}>{e.konum}</td>
                  <td style={{padding:"10px 12px"}}><Badge color={k ? C.coral : C.green1}>{k ? "Kritik" : "Yeterli"}</Badge></td>
                  {rol !== "kursiyer" && <td style={{padding:"10px 8px",textAlign:"center"}}><button onClick={function(){setSilId(e.id);}} style={{background:"none",border:"none",cursor:"pointer",padding:4,borderRadius:6}} title="Sil"><Icon name="alert" size={14} color={C.coral}/></button></td>}
                </tr>
              );
            })}</tbody>
          </table>
        </div>
      </div>
      {showLog !== null && logItem.length > 0 && (
        <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.borderLight,padding:18,marginTop:14,animation:"fadeUp .3s ease"}}>
          <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:12}}>
            <div style={{fontSize:13,fontWeight:700}}>{logAd} - Stok Hareket Gecmisi</div>
            <button onClick={function(){setShowLog(null);}} style={{background:"none",border:"none",cursor:"pointer",fontSize:16,color:C.textMuted}}>x</button>
          </div>
          <div style={{display:"grid",gap:6}}>
            {logItem.slice().reverse().map(function(l, i) {
              var isEksilt = l.tip === "eksilt";
              return (
                <div key={i} style={{display:"flex",alignItems:"center",gap:10,padding:"8px 12px",borderRadius:10,background:isEksilt ? C.coral+"06" : C.green1+"06",border:"1px solid "+(isEksilt ? C.coral+"15" : C.green1+"15")}}>
                  <div style={{width:28,height:28,borderRadius:8,background:isEksilt ? C.coral+"15" : C.green1+"15",display:"flex",alignItems:"center",justifyContent:"center",fontSize:14,fontWeight:800,color:isEksilt ? C.coral : C.green1,flexShrink:0}}>{isEksilt ? "-" : "+"}</div>
                  <div style={{flex:1,minWidth:0}}>
                    <div style={{fontSize:12,fontWeight:700,color:C.text}}>{l.miktar} {l.birim} - {l.neden}</div>
                    {l.not && <div style={{fontSize:10,color:C.textSoft,marginTop:1}}>{l.not}</div>}
                  </div>
                  <div style={{fontSize:10,color:C.textMuted,flexShrink:0}}>{l.tarih}</div>
                </div>
              );
            })}
          </div>
        </div>
      )}
      {showLog !== null && logItem.length === 0 && (
        <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.borderLight,padding:18,marginTop:14,textAlign:"center",animation:"fadeUp .3s ease"}}>
          <div style={{fontSize:12,color:C.textMuted}}>Henuz hareket kaydi yok.</div>
        </div>
      )}
      {stokModal && modalItem && (
        <div style={{position:"fixed",inset:0,background:"rgba(0,0,0,0.4)",display:"flex",alignItems:"center",justifyContent:"center",zIndex:200,backdropFilter:"blur(3px)"}}>
          <div style={{background:C.card,borderRadius:20,padding:"28px 32px",maxWidth:420,width:"90%",boxShadow:"0 20px 60px rgba(0,0,0,0.2)",animation:"fadeUp 0.3s ease"}}>
            <div style={{display:"flex",alignItems:"center",gap:10,marginBottom:18}}>
              <div style={{width:42,height:42,borderRadius:12,background:(stokModal.tip==="eksilt" ? C.coral : C.green1)+"15",display:"flex",alignItems:"center",justifyContent:"center",fontSize:20,fontWeight:900,color:stokModal.tip==="eksilt" ? C.coral : C.green1}}>{stokModal.tip==="eksilt" ? "-" : "+"}</div>
              <div>
                <div style={{fontSize:15,fontWeight:800,color:C.text}}>Stok {stokModal.tip==="eksilt" ? "Eksilt" : "Ekle"}</div>
                <div style={{fontSize:12,color:C.textMuted}}>{modalItem.ad} (Mevcut: {modalItem.stok} {modalItem.birim})</div>
              </div>
            </div>
            <div style={{display:"grid",gap:12}}>
              <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Miktar ({modalItem.birim})</label><input type="number" value={stokMiktar} onChange={function(e){setStokMiktar(e.target.value);}} min="1" style={{width:"100%",padding:"9px 14px",borderRadius:9,border:"1px solid "+C.border,fontSize:13,fontWeight:700,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
              <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Tarih</label><input type="date" value={stokTarih} onChange={function(e){setStokTarih(e.target.value);}} style={{width:"100%",padding:"9px 14px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
              <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Neden</label><select value={stokNeden} onChange={function(e){setStokNeden(e.target.value);}} style={{width:"100%",padding:"9px 14px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",background:"#fff"}}>{stokModal.tip==="eksilt" ? [<option key="1">Kullanim</option>,<option key="2">Bozulma / Fire</option>,<option key="3">Dagitim</option>,<option key="4">Kayip</option>,<option key="5">Diger</option>] : [<option key="1">Satin Alma</option>,<option key="2">Bagis</option>,<option key="3">Iade</option>,<option key="4">Uretim</option>,<option key="5">Diger</option>]}</select></div>
              <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Not (istege bagli)</label><input value={stokNot} onChange={function(e){setStokNot(e.target.value);}} placeholder="Aciklama ekleyin..." style={{width:"100%",padding:"9px 14px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
            </div>
            {stokModal.tip==="eksilt" && parseInt(stokMiktar) > modalItem.stok && (
              <div style={{marginTop:10,padding:"8px 12px",background:C.coral+"08",borderRadius:8,fontSize:11,color:C.coral,fontWeight:600}}>Mevcut stoktan ({modalItem.stok}) fazla dusurulenemez!</div>
            )}
            <div style={{display:"flex",gap:8,justifyContent:"flex-end",marginTop:18}}>
              <Btn small onClick={function(){setStokModal(null);}}>Vazgec</Btn>
              <button onClick={doStokIslem} disabled={stokModal.tip==="eksilt" && parseInt(stokMiktar) > modalItem.stok} style={{padding:"8px 20px",borderRadius:10,border:"none",background:stokModal.tip==="eksilt" ? "linear-gradient(135deg,"+C.coral+",#C62828)" : "linear-gradient(135deg,"+C.green1+","+C.greenDark+")",color:"#fff",fontSize:12,fontWeight:700,cursor:"pointer",boxShadow:"0 2px 10px "+(stokModal.tip==="eksilt" ? C.coral : C.green1)+"40",opacity:(stokModal.tip==="eksilt" && parseInt(stokMiktar) > modalItem.stok) ? 0.5 : 1}}>{stokModal.tip==="eksilt" ? "Dusur" : "Ekle"}</button>
            </div>
          </div>
        </div>
      )}
      {silId !== null && (
        <div style={{position:"fixed",inset:0,background:"rgba(0,0,0,0.4)",display:"flex",alignItems:"center",justifyContent:"center",zIndex:200,backdropFilter:"blur(3px)"}}>
          <div style={{background:C.card,borderRadius:20,padding:"28px 32px",maxWidth:380,width:"90%",boxShadow:"0 20px 60px rgba(0,0,0,0.2)",animation:"fadeUp 0.3s ease"}}>
            <div style={{display:"flex",alignItems:"center",gap:10,marginBottom:16}}>
              <div style={{width:42,height:42,borderRadius:12,background:C.coral+"15",display:"flex",alignItems:"center",justifyContent:"center"}}><Icon name="alert" size={22} color={C.coral}/></div>
              <div><div style={{fontSize:15,fontWeight:800,color:C.text}}>Malzeme Sil</div><div style={{fontSize:12,color:C.textMuted}}>Bu islem geri alinamaz</div></div>
            </div>
            <div style={{padding:"14px 16px",background:C.coral+"08",borderRadius:12,marginBottom:18,fontSize:13,lineHeight:1.6,color:C.text}}>
              <b>{silAd}</b> malzemesini envanterden silmek istediginize emin misiniz?
            </div>
            <div style={{display:"flex",gap:8,justifyContent:"flex-end"}}>
              <Btn small onClick={function(){setSilId(null);}}>Vazgec</Btn>
              <button onClick={doSil} style={{padding:"8px 20px",borderRadius:10,border:"none",background:"linear-gradient(135deg,"+C.coral+",#C62828)",color:"#fff",fontSize:12,fontWeight:700,cursor:"pointer",boxShadow:"0 2px 10px "+C.coral+"40"}}>Evet, Sil</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};


var BILGI_TABANI = `
=== KENT BOSTANI TEKNIK REHBER ===
Hazirlayan: Zir. Muh. Sertac HEKIM, Cankaya Belediyesi Park ve Bahceler Mudurlugu

--- KURULUS ---
Kurulusunun amaci semt sakinlerine dogal tarim yontemleri, atalik tohumlarla sebze yetistiriciligi ve ekolojik yaklasimlarin egitimlerini vermektir. Kimyasal girdi kullanilmaz, organik tarim yonetmeligi baz alinir.
2 da alan: 1 da egitim siniflari/ofisler, 1 da ekim-dikim alani (350m2), dikey yetistirme ornekleri.
Egitimler ucretsizdir. Parsel sahipleri alan icin ucret odemez, urettikleri tohumlardan bir kismini verirler.
90 kisilik buyuk salon, 30 kisilik kucuk sinif.

--- PARSEL KULLANIM KOSULLARI ---
- Parsel istek listesinde bulunmak
- 2 haftadan fazla parseli birakmamak
- Gorevli teknik personel kontrolu disinda uretim materyali bulunduramaz (fide, tohum, gubre, ilac)
- Temel sebzecilik egitimlerini almis olmak
- Mumkunse yuruyus mesafesinde oturmak
- Alan ici duzen ve temizlikten sorumlu olmak

--- EGITIM KONULARI ---
1. TEMEL SEBZECILIK: Yerel tohum, tohumdan fideye, bitki besinleri, yasayan toprak, sebze hastaliklari, dost bocekler, ugurbocegi uretimi
2. MEVSIMSEL SEBZE: Domates, biber, salatalik, fasulye, misir, kavun, kabak, tibbi aromatik bitkiler
3. BUDAMA VE ASILAMA: Meyve agaclarinda budama, gul ve cali budamasi, asilama
4. EKOLOJIK YAKLASIMLAR: Evde kompost, yagmur hasadi, dikey bahce, bahce guzellestirme, dis mekan bitkileri, meyve agaci yetistirme
5. TEMEL ARICILIK: Bal arisi irklari, mevsimsel bakim, bal uretimi, diger ari urunleri
6. GUZLUK SEBZELER: Ispanak, sogan, turp, pirasa, havuc, urun isleme (sos, konserve)

--- YEREL TOHUM ---
Bolgesine ozel, yillar boyunca uretilmis, dayanikli tohumlar. Hibrit tohumlara gore avantajlari:
- Bolgesine uyumlu, cevre sartlarina dayanikli
- Yabanci otlara baskin, besleme maliyeti dusuk
- Hastalik/zararlilara dayanikli, su/nem uyumu iyi
- Besin degerleri yuksek
Hibrit cesitlerde son 50 yilda protein, kalsiyum, fosfor, demir, C vitamini dusmus. Ispanakta C vitamini %52 dusmus.

--- BITKI YETISTIRME ETKENLERI ---
ISI: Cimlenmede en iyi 34-36C. Minimum 15C, maksimum 38-40C.
Sicaklik tercihleri: 21C (kereviz,ispanak), 24C (kuskonmaz,marul,sogan,bezelye,havuc), 26.5C (domates,karnibahar), 30C (fasulye,lahana,patlican,biber), 35C (hiyar,karpuz,bamya,kavun)
NEM: Toprakta %25 hava, %25 su ideal.
TOPRAK: Ideal toprakta kil %20-30, silt %30-50, kum %20-50, organik madde %5-10.

--- TOPRAK HAZIRLIK KARISIMLARI ---
3lu: %50 toprak, %25 dere mili, %25 torf
4lu: %50 toprak, %25 dere mili, %20 torf, %5 gubre
5li: %30 toprak, %30 torf, %20 gubre, %10 pomza, %10 dere mili
Tohum yatagi: 2 parca nehir kumu + 1 parca humus + 1 parca perlit

--- EKIM-DIKIM ZAMANLARI (ANKARA) ---
Domates: Ekim Mart 3.hafta, Dikim Mayis 2.hafta (35-40 gun)
Biber: Ekim Mart 2.hafta, Dikim Mayis 2.hafta (40-45 gun)
Salatalik: Ekim Nisan 2.hafta, Dikim Mayis 2.hafta (25-30 gun)
Kabak: Ekim Nisan 2.hafta, Dikim Mayis 2.hafta (25-30 gun)
Fasulye: Ekim Nisan 2.hafta, Dikim Mayis 2.hafta (20-25 gun)
Misir: Ekim Nisan 1.hafta, Dikim Mayis 2.hafta (30-35 gun)
Tohum ekim derinligi: Kucuk tohumlar 3 kati, buyuk tohumlar 2 kati.

--- DIKIM MESAFELERI ---
Domates: 60x70 cm, Biber: 40x60 cm, Kavun: 50x200 cm, Marul: 15x20 cm, Cilek: 30x30 cm, Misir: 15x15 cm, Salatalik: 40x60 cm
Dikim zamani: Toprak ve hava 12-13C, ilkbahar donlari gectikten sonra.

--- HASTALIKLAR ---
BAKTERIYEL: Yaniklik, lekeler, kurumalar, solmalar, kok curumeleri. Mucadele: Bulasmayaengellemek, bakirli ilaclar.
FUNGUSLAR: Kulleme, mildiyo, yaprak lekesi.
Kulleme ilaci: 1lt suya 5gr islanabilir toz kukurt puskurt. Veya 1lt suya 10gr karbonat.
Mildiyo ilaci: 1yk karbonat + 1yk zeytinyagi + 1yk arapsabunu + 4lt su. Veya 3yk elma sirkesi + 4lt su.
Yaprak lekesi: 3 dis sarimsak + 1 sogan + 1ck aci biber + 1lt suda 10dk beklet, suzup uygula.

--- ZARARLILAR ---
Danaburnu: At gubresi tuzak yontemi, isik tuzaklari.
Kirmizi orumcek: 1lt suya 5gr toz kukurt puskurt.
Yaprak bitleri: 4 dis sarimsak ezilir + 2ck sivi yag + 1ck aci biber + 1lt su, 1 gun beklet, suz, puskurt.
Salyangoz/beyaz sinek: 1 bas sarimsak-sogan rendele + 1yk aci biber + 1lt su + 1yk sivi sabun, 1 saat beklet.
Faydali bocekler: Ugur bocegi, altingozlu bocek, peygamber devesi, avcisinek.

--- GUBRE VE BESLEME ---
ANA ELEMENTLER: Azot(dal icin), Fosfor(dol/cicek icin), Potasyum(meyve icin)
Hayvan gubresi: Dekara 3-5 ton (1m2ye 3kg). Tavuk gubresi azot ve fosfor yuksek.
Kompost: Evsel atiklar + karbon kaynagi ile alevsiz yanma.
Bokasi: Organik atiklarin fermantasyon ile gubre yapimi. 2-4 hafta.
Eko Enzim: Meyve kabuklari + kahverengi seker + su, 3 ay fermantasyon, 1/100 seyrelt.

EV YAPIMI GUBRELER:
- Azot: Isirgan otu gubresi (2 hafta, 15-20/1 seyrelterek)
- Potasyum: Muz kabuklari (gun asiri karistir, suz)
- Fosfor: Kanatli gubresi + solucan gubresi (cicek oncesi, kok cevresine 200gr+150gr)
- Kalsiyum: Yumurta kabuklari (200C firinda 10dk, toz yap) veya yagsiz sut (4lt suya 1lt sut)
Mikrobiyolojik gubreler: Mikoriza (kok temaslı, tek sefer), Rizobium

--- 10m2 BAHAR DONEMI UYGULAMA PLANI ---
MART BASI: Buyukbas hayvan gubresi 20kg/10m2, yuzeye ser, 5-10cm karistir, sula
MART ORTASI: EM (10L su + 20-30ml EM), gubreden 7-10 gun sonra
MART SONU: Humik Asit (10L su + 10-15ml HA), EM den 5-7 gun sonra
NISAN: Bokasi cayi (10L su + 1L suzulmus bokasi cayi), ayda 1
MAYIS FIDE DIKIMI: Mikoriza fide cukuruna kok temasli. AYNI GUN EM, bokasi, kanatli gubresi VERME!
MAYIS +7-10 GUN: Humik Asit (10L su + 20ml HA)
MAYIS SONU/HAZIRAN: Kanatli gubresi 5-7kg/10m2 (1 kez), bitkiden 10-15cm uzaga
DIKIM ONCESI: Toz kukurt 200-300g/10m2, kanatli gubreyle ayni anda verme!
ALTIN KURAL: Toprak hazirlir > kokle bag kurulur > en son ciceklenme desteklenir.

--- TERRARYUM ATOLYESI REHBERI ---
Terraryum: Toprak (terra) + akvaryum (arium). Seffaf cam icinde minyatur yasam alanlari.
Oksijen uretir, havayi temizler, dekoratif, stres azaltici.
4 tur: Acik sistemler, Kapali sistemler, Kurak sistemler, Nemli sistemler.

TERRARYUM YAPIM ADIMLARI:
1. Malzeme sec: Cam kavanoz/kap, toprak, kucuk taslar, aktif karbon, bitki, aksesuarlar
2. Taban hazirligi: Kucuk cakillarla drenej katmani + aktif karbon (koku emici)
3. Toprak katmani: Aktif karbon uzerine kok yapisina uygun kalinlikta toprak
4. Bitki secimi ve yerlestirme: Kucuk bitkiler, sukulentler, farkli turler
5. Aksesuarlar ve dekor: Kucuk taslar, heykeller, yosunlar, kumlar
6. Bakim: Nem ve isik takibi, ihtiyac halinde sulama, dogrudan gunes isigi yok

TERRARYUM KATMANLARI (alttan uste): Aktif karbon > Drenej katmani > Toprak > Kurucu bitki > Aksesuarlar > Bitki

BITKI GRUPLARI:
1. Kurucu bitkiler: Fittonia, Pilea, Selaginella, Hedera, Yosunlar (ana yapi)
2. Dolgu bitkileri: Tum farkli yosun cesitleri (destek)
3. Sus bitkileri: Tasarimi renklendirecek bitkiler (kompozisyon)

NEMLI TERRARYUM BITKILERI: Fittonia, Pilea, Maidenhair Fern, Egrelti otlari, Yosunlar, Bromeliads, Begonia, Peperomia, orkide, antoryum
KURAK TERRARYUM BITKILERI: Sukulent (Echeveria, Sedum, Crassula, Aeonium), Kaktusler (Haworthia, Aloe Vera), yilan derisi sukulent

TERRARYUM YAPILAN HATALAR:
1. Asiri sulama (toprak kuruduktan sonra sula)
2. Asiri gunes isigi (dogrudan gunes zarali)
3. Havalandirma ihlali (kapali kapta hava sirkulasyonu gerekli)
4. Buyuk bitki secimi (kucuk kapta buyuk bitki yer kaplar)
5. Farkli nem ihtiyacli bitkileri bir arada kullanma

SULAMA YONTEMLERI: Parmakla nem kontrolu, puskurtme yontemi, alt tabakadan sulama. Ideal: 2 haftada bir. Fazla su zararli.

--- PARSEL UYGULAMA REHBERI (Kursiyerler Icin) ---
1. DIKIM ONCESI (1.Hafta): m2ye 3kg iyi yanmis hayvan gubresi karistir. m2ye 50gr toz kukurt pH icin. Kompost/bokasi 1-2 ay once topraga karistir. Damlama hatlari kontrol. Her cukura 1 avuc kompost/solucan gubresi.
2. FIDE DIKIMI (15-19 Mayis): Sabah/aksam dik. Toprakla kok ort. Etiketle. Damlama 10-15dk calistir.
3. ALISMA SURECI (Ilk 2 Hafta): Sulama 2 gunde bir 10-15dk damlama. Her 3 sulamada bir humik asit. Domates/salatalik icin destek cubugu. Yaprak takibi: sararma/solma varsa bildir.
4. BUYUME DONEMI (3-6.Hafta): Haftada 2 sulama. 3-4 sulamada bir derin sulama (2 saat damlama). Ayda 1 kompost cayi/sivi solucan gubresi (1/10). 2 haftada bir hayvan gubresi (250gr/m2) + solucan gubresi (50gr/m2). Yabanci ot temizligi. Capalama.
5. MEYVE VE CICEK DONEMI (6-9.Hafta): Sulama + sivi besin (humik asit, deniz yosunu, kanatli gubresi). Koltuk alma (domates/salatalik). Zararli/hastalik kontrolu.
6. HASAT VE BAKIM (10.Hafta+): Haftalik hasat. Bozuk meyve/fide dipten al. Gece 20C gecince aksam sulamasi yapma. Yeni cicek takibi.

EVSEL ILACLAMA REHBERI:
- Yaprak biti: 1lt su + 1ck sivi sabun + 1tk zeytinyagi, sprey 3 gunde 1. VEYA 1lt su + 1yk arap sabunu + 70ml kolonyagi
- Kirmizi orumcek/trips/beyaz sinek: Azadraktin+neem yagi veya gulleci bulamaci, yaprak altlarina sprey
- Mildiyo/Kulleme: 1lt su + 1tk karbonat + birkac damla sabun, haftada 1 sprey
- Mantar baslangici: 1 su bardagi elma sirkesi + 2lt su, sabah sprey
- Kok curuklugu: Asiri sulama yapma, fide dibi kurudukca sula

GENEL TAVSIYELER: Gunluk 5 dakikalik gozlem en iyi bakimdir. Fidelerle konus, gozle, degisimi fark et. Komsu parselle deneyim paylas.

--- 100m2 GIDA SISTEMI REHBERI ---
100m2 Mucizesi: Kendi Gidani Yetistirme Rehberi. Ankara kosullarinda bilimsel verilerle 4 kisilik bir ailenin sebze ihtiyacini karsilamak.

4 KISILIK AILE YILLIK SEBZE IHTIYACI: ~500 kg
100m2 bostandan yillik hasat: ~350 kg (%60-80 karsilanir)
Urun bazinda: Domates ~40kg, Sogan/sarimsak ~40kg, Yesil yaprakli ~135kg, Biber ~24kg, Salatalik ~28kg, Kabak ~28kg, Fasulye ~19kg
Bu sadece sebze ihtiyacini kapsar. Vitamin, mineral, lif ve fitokimyasal ihtiyacinin buyuk kismini karsilar.

PERMAKULTÜR VE YON ANALIZI:
- Kuzey: Ruzgar kirici cok yilliklar (lavanta, biberiye vb.)
- Dogu: Sabah gunesi sevenler (marul, ispanak)
- Guney: Sicagi sevenler (domates, biber, patlican)
- Bati: Aromatik koku kalkani (feslegen, sarimsak)
- Kose: Kompost ve yasam alani

KARDES BITKI FELSEFESI:
- Gunes Paylasimi: Uzun bitkiler kisalari golgelemek yerine destek olur
- Kok Rekabeti Yok: Farkli derinliklere inen kokler besin icin kavga etmez
- Koku Kalkani: Aromatik bitkiler zararlilarin kafasini karistirir
- Besin Dengesi: Bazi bitkiler topraga azot baglar, digerleri kullanir
- Su Ortakligi: Benzer su ihtiyaci olan bitkiler bir arada daha verimli

ORNEK KASA PLANLARI:
1. Domates Kasasi: Domates + sarimsak (kok nematodlarini basklar) + kadife cicegi (mantar riskini azaltir, beyaz sinegi uzaklastirir)
2. Uc Kiz Kardes Sistemi: Misir (fasulyeye dogal sirik) + Fasulye (kokleriyle topraga azot baglayarak misiri ve kabagi besler) + Kabak (genis yapraklariyla topragi golgeler, nemi korur, yabani otlari engeller)

3 KATMANLI DOGAL KORUMA KALKANI (Kimyasala Hayir):
1. Katman - TUZAK BITKILER: Zararlıyi kendi uzerine cekerek ana urunu feda eder. Ornekler: Latin Cicegi (yaprak bitini ceker), Kadife Cicegi (nematodlari ceker), Turp (pire bocegini ceker)
2. Katman - KACIRICI BITKILER: Guclu kokulariyla zararlilarin yonunu sasirtir. Ornekler: Feslegen, Sarimsak, Biberiye, Adacayi
3. Katman - CEKICI BITKILER: Faydali bocekleri (ugur bocegi, ari) davet ederek dogal bir ordu kurar. Ornekler: Lavanta, Papatya, Dereotu, Kisnis

BOSTANIN ILK YARDIM CANTASI (Ev Yapimi Dogal Ilaclar):
1. Sarimsak+Sogan Spreyi (Genel Kovucu): Beyaz sinek, trips, yaprak biti icin. 10 dis sarimsak + 1 sogan + 1 aci biber + 1lt su. Blenderdan gecir, 24 saat beklet, suz. 1lt suya 100ml ekleyerek kullan.
2. Isirgan Fermentesi (Yaprak Biti Cozumu): Yaprak biti kolonilerini cokertir, bitkiyi besler. 200gr taze isirgan + 2lt su. 3-5 gun fermente et, suz. 1lt suya 50ml ekleyerek kullan.
3. Sabunlu Su Spreyi (Hizli Mudahale): Boceklerin uzerine dogrudan sikilir, aninda etki eder. 1lt su + 1ck saf zeytinyagi sabunu rendesi. Karistir ve gun batiminda uygula.

CANLI TOPRAK YARATMA SANATI (Bitkiyi degil, topragi besle):
3 Anahtar: 1) Organik Madde (kompost, bokashi, yesil gubre), 2) Mikroorganizmalar (LAB, kompost cayi), 3) Mineraller (odun kulu=potasyum, yumurta kabuğu tozu=kalsiyum)

SIFIR ATIK GUBRE DONGUSU:
Girdiler: Kuru yapraklar, budama artiklari, sokulen bitkiler, mutfak atiklari
Surecler: Sicak Kompost (6-8 haftada zengin toprak), Bokashi (2 haftada fermente super gida), Bitki Caylari/FPJ (taze bitkilerden sivi besin)
Ciktilar: Yuksek kaliteli kati gubre, besleyici sivi gubreler

BUTUNSEL SU YONETIMI (Ankara Icin):
1. Toplama: Catidan yagmur suyu hasadi
2. Depolama: 1000L tank ile yaz icin birikim
3. Verimli Sulama: Damlama sulama ile dogrudan koke
4. Koruma: Malclama ile buharlasmayi %60 azaltma
5. Drenaj: Yukseltilmis kasa ile mukemmel drenaj

YILLIK BOSTAN RITMI (Ankara):
- Kis (Aralik-Subat): Ortu alti uretim (alcak tunel), bostanin korunmasi, yeni sezon planlamasi
- Ilkbahar (Mart-Mayis): Fide dikimleri, topraga kompost ekleme, bezelye/bakla ekimi
- Yaz (Haziran-Agustos): Ana hasat donemi, duzenli sulama, zararli takibi, sonbahar icin ekim hazirligi
- Sonbahar (Eylul-Kasim): Donus ekimleri (marul, ispanak, turp), sarimsak ekimi, kompost hazirligi

100m2 CANLI EKOSISTEM: Akilli Tasarim (Permakultür Bolgeleri) + Kardes Bitki Takimlari + 3 Katmanli Dogal Koruma + Canli Toprak & Gubre Dongusu + Butunsel Su Yonetimi + Yillik Uretim Ritmi = Saglikli ve Verimli Bostan. Her parca digerini destekler, sistem parcalarin toplamindan daha fazlasidir.



--- ILETISIM ---
Mail: kenttarimbirimi@gmail.com
Instagram: @kenttarim
Facebook: Kent ve tarim calisma ekibi
Tel: 0312 235 3973, Merkez: 458 89 00
`;

var EGITIM_PROGRAMI = {
  mutlukent: [
    {id:"m1",baslik:"Meyve Agaclarinda Budama",tarih:"14 Ocak, Carsamba",iso:"2026-01-14",saat:"12:30-14:30",katilim:28,islendi:true},
    {id:"m2",baslik:"Gul, Cali Budamasi",tarih:"21 Ocak, Carsamba",iso:"2026-01-21",saat:"12:30-14:30",katilim:32,islendi:true},
    {id:"m3",baslik:"Asilama ve Asma Budamasi",tarih:"28 Ocak, Carsamba",iso:"2026-01-28",saat:"12:30-14:30",katilim:26,islendi:true},
    {id:"m4",baslik:"Yerel Tohumun Onemi / Tohumdan Fideye",tarih:"4 Subat, Carsamba",iso:"2026-02-04",saat:"12:30-14:30",katilim:35,islendi:true},
    {id:"m5",baslik:"Sebzelerde Hastaliklar / Yasayan Toprak",tarih:"11 Subat, Carsamba",iso:"2026-02-11",saat:"12:30-14:30",katilim:30,islendi:true},
    {id:"m6",baslik:"Bahcenizi Guzellestirme Teknikleri",tarih:"18 Subat, Carsamba",iso:"2026-02-18",saat:"12:30-14:30",katilim:38,islendi:true},
    {id:"m7",baslik:"Dis Mekan Bitkilerini Taniyalim",tarih:"25 Subat, Carsamba",iso:"2026-02-25",saat:"12:30-14:30",katilim:33,islendi:true},
    {id:"m8",baslik:"100m2 Bostan Kurulumu / Ugurbocegi Uretimi",tarih:"4 Mart, Carsamba",iso:"2026-03-04",saat:"12:30-14:30",katilim:0,islendi:false},
    {id:"m9",baslik:"Meyve Agaclarinin Yetistirilmesi",tarih:"11 Mart, Carsamba",iso:"2026-03-11",saat:"12:30-14:30",katilim:0,islendi:false},
    {id:"m10",baslik:"Sulama Sistemlerinde Pratik Bilgiler",tarih:"18 Mart, Carsamba",iso:"2026-03-18",saat:"12:30-14:30",katilim:0,islendi:false},
    {id:"m11",baslik:"Terraryum Nasil Yapilir? / Uygulama",tarih:"25 Mart, Carsamba",iso:"2026-03-25",saat:"12:30-14:30",katilim:0,islendi:false},
    {id:"m12",baslik:"Yagmur Suyu Hasadi",tarih:"1 Nisan, Carsamba",iso:"2026-04-01",saat:"12:30-14:30",katilim:0,islendi:false},
    {id:"m13",baslik:"Domates, Biber Nasil Yetistirilir?",tarih:"8 Nisan, Carsamba",iso:"2026-04-08",saat:"12:30-14:30",katilim:0,islendi:false},
    {id:"m14",baslik:"Salatalik, Fasulye Nasil Yetistirilir?",tarih:"15 Nisan, Carsamba",iso:"2026-04-15",saat:"12:30-14:30",katilim:0,islendi:false},
    {id:"m15",baslik:"Misir, Kabak ve Kavun Nasil Yetistirilir?",tarih:"22 Nisan, Carsamba",iso:"2026-04-22",saat:"12:30-14:30",katilim:0,islendi:false},
    {id:"m16",baslik:"Cilek, Marul Nasil Yetistirilir?",tarih:"29 Nisan, Carsamba",iso:"2026-04-29",saat:"12:30-14:30",katilim:0,islendi:false},
    {id:"m17",baslik:"Evde Kompost ve Solucan Gubresi Yapimi",tarih:"6 Mayis, Carsamba",iso:"2026-05-06",saat:"12:30-14:30",katilim:0,islendi:false}
  ],
  ata: [
    {id:"a1",baslik:"Meyve Agaclarinda Budama",tarih:"15 Ocak, Persembe",iso:"2026-01-15",saat:"13:00-15:00",katilim:18,islendi:true},
    {id:"a2",baslik:"Gul, Cali Budamasi",tarih:"22 Ocak, Persembe",iso:"2026-01-22",saat:"13:00-15:00",katilim:22,islendi:true},
    {id:"a3",baslik:"Asilama ve Asma Budamasi",tarih:"29 Ocak, Persembe",iso:"2026-01-29",saat:"13:00-15:00",katilim:16,islendi:true},
    {id:"a4",baslik:"Yerel Tohumun Onemi / Tohumdan Fideye",tarih:"5 Subat, Persembe",iso:"2026-02-05",saat:"13:00-15:00",katilim:24,islendi:true},
    {id:"a5",baslik:"Sebzelerde Hastaliklar / Yasayan Toprak",tarih:"12 Subat, Persembe",iso:"2026-02-12",saat:"13:00-15:00",katilim:20,islendi:true},
    {id:"a6",baslik:"Bahcenizi Guzellestirme Teknikleri",tarih:"19 Subat, Persembe",iso:"2026-02-19",saat:"13:00-15:00",katilim:25,islendi:true},
    {id:"a7",baslik:"Dis Mekan Bitkilerini Taniyalim",tarih:"26 Subat, Persembe",iso:"2026-02-26",saat:"13:00-15:00",katilim:21,islendi:true},
    {id:"a8",baslik:"100m2 Bostan Kurulumu / Ugurbocegi Uretimi",tarih:"5 Mart, Persembe",iso:"2026-03-05",saat:"13:00-15:00",katilim:0,islendi:false},
    {id:"a9",baslik:"Meyve Agaclarinin Yetistirilmesi",tarih:"12 Mart, Persembe",iso:"2026-03-12",saat:"13:00-15:00",katilim:0,islendi:false},
    {id:"a10",baslik:"Sulama Sistemlerinde Pratik Bilgiler",tarih:"26 Mart, Persembe",iso:"2026-03-26",saat:"13:00-15:00",katilim:0,islendi:false},
    {id:"a11",baslik:"Terraryum Nasil Yapilir? / Uygulama",tarih:"2 Nisan, Persembe",iso:"2026-04-02",saat:"13:00-15:00",katilim:0,islendi:false},
    {id:"a12",baslik:"Yagmur Suyu Hasadi",tarih:"9 Nisan, Persembe",iso:"2026-04-09",saat:"13:00-15:00",katilim:0,islendi:false},
    {id:"a13",baslik:"Domates, Biber Nasil Yetistirilir?",tarih:"16 Nisan, Persembe",iso:"2026-04-16",saat:"13:00-15:00",katilim:0,islendi:false},
    {id:"a14",baslik:"Salatalik, Fasulye Nasil Yetistirilir?",tarih:"30 Nisan, Persembe",iso:"2026-04-30",saat:"13:00-15:00",katilim:0,islendi:false},
    {id:"a15",baslik:"Misir, Kabak ve Kavun Nasil Yetistirilir?",tarih:"7 Mayis, Persembe",iso:"2026-05-07",saat:"13:00-15:00",katilim:0,islendi:false},
    {id:"a16",baslik:"Cilek, Marul Nasil Yetistirilir?",tarih:"14 Mayis, Persembe",iso:"2026-05-14",saat:"13:00-15:00",katilim:0,islendi:false},
    {id:"a17",baslik:"Evde Kompost ve Solucan Gubresi Yapimi",tarih:"21 Mayis, Persembe",iso:"2026-05-21",saat:"13:00-15:00",katilim:0,islendi:false}
  ]
};

const Kurslar = ({bostan, rol}) => {
  const [tab, setTab] = useState("mutlukent");
  const [editId, setEditId] = useState(null);
  const [editVal, setEditVal] = useState("");
  const [ver, setVer] = useState(0);
  var bugun = new Date().toISOString().slice(0,10);
  var prog = (EGITIM_PROGRAMI[tab] || []).map(function(e) {
    var gecmis = e.iso <= bugun;
    var durum = gecmis ? (e.katilim > 0 ? "islendi" : "eksik") : "bekliyor";
    return {id:e.id,baslik:e.baslik,tarih:e.tarih,saat:e.saat,iso:e.iso,katilim:e.katilim,islendi:durum==="islendi",durum:durum};
  });
  var bAd = BOSTANLAR[tab] ? BOSTANLAR[tab].kisa : "";
  var bRenk = BOSTANLAR[tab] ? BOSTANLAR[tab].renk : C.green1;
  var gun = tab === "mutlukent" ? "Carsamba 12:30-14:30" : "Persembe 13:00-15:00";
  var islenmis = prog.filter(function(e){return e.islendi;});
  var ort = islenmis.length > 0 ? Math.round(islenmis.reduce(function(s,e){return s+e.katilim;},0) / islenmis.length) : 0;
  var maxK = islenmis.length > 0 ? Math.max.apply(null, islenmis.map(function(e){return e.katilim;})) : 0;
  var mIsl = EGITIM_PROGRAMI.mutlukent.filter(function(e){return e.islendi;});
  var aIsl = EGITIM_PROGRAMI.ata.filter(function(e){return e.islendi;});
  var chartData = [];
  var maxLen = Math.max(mIsl.length, aIsl.length);
  for (var ci = 0; ci < maxLen; ci++) {
    var row = {ad: (ci+1) + ". Ders"};
    if (mIsl[ci]) row.Mutlukent = mIsl[ci].katilim;
    if (aIsl[ci]) row.Ata = aIsl[ci].katilim;
    chartData.push(row);
  }
  var doKaydet = function(eId) {
    var sayi = parseInt(editVal);
    if (!isNaN(sayi) && sayi >= 0) {
      EGITIM_PROGRAMI[tab] = EGITIM_PROGRAMI[tab].map(function(e) {
        if (e.id === eId) return {id:e.id,baslik:e.baslik,tarih:e.tarih,saat:e.saat,katilim:sayi,islendi:true};
        return e;
      });
      setVer(ver + 1);
    }
    setEditId(null);
    setEditVal("");
  };
  var doSifirla = function(eId) {
    EGITIM_PROGRAMI[tab] = EGITIM_PROGRAMI[tab].map(function(e) {
      if (e.id === eId) return {id:e.id,baslik:e.baslik,tarih:e.tarih,saat:e.saat,katilim:0,islendi:false};
      return e;
    });
    setVer(ver + 1);
  };
  return (
    <div>
      <div style={{display:"flex",gap:0,marginBottom:18,background:C.card,borderRadius:14,border:"1px solid "+C.borderLight,overflow:"hidden",width:"fit-content"}}>
        {[{k:"mutlukent",l:"Mutlukent",r:BOSTANLAR.mutlukent.renk},{k:"ata",l:"Ata Kent",r:BOSTANLAR.ata.renk}].map(function(t){
          var act = tab === t.k;
          return <button key={t.k} onClick={function(){setTab(t.k);setEditId(null);}} style={{padding:"10px 24px",border:"none",cursor:"pointer",fontSize:13,fontWeight:act ? 800 : 600,background:act ? t.r : "transparent",color:act ? "#fff" : C.textSoft,transition:"all 0.2s"}}>{t.l}</button>;
        })}
      </div>
      <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(130px,1fr))",gap:12,marginBottom:18}}>
        <div style={{background:C.card,borderRadius:14,border:"1px solid "+C.borderLight,padding:"14px 18px",textAlign:"center"}}>
          <div style={{fontSize:10,fontWeight:700,color:C.textMuted,marginBottom:4}}>Toplam Ders</div>
          <div style={{fontSize:26,fontWeight:900,color:bRenk}}>{prog.length}</div>
        </div>
        <div style={{background:C.card,borderRadius:14,border:"1px solid "+C.borderLight,padding:"14px 18px",textAlign:"center"}}>
          <div style={{fontSize:10,fontWeight:700,color:C.textMuted,marginBottom:4}}>Islenen</div>
          <div style={{fontSize:26,fontWeight:900,color:C.green1}}>{islenmis.length}</div>
        </div>
        <div style={{background:C.card,borderRadius:14,border:"1px solid "+C.borderLight,padding:"14px 18px",textAlign:"center"}}>
          <div style={{fontSize:10,fontWeight:700,color:C.textMuted,marginBottom:4}}>Ort. Katilim</div>
          <div style={{fontSize:26,fontWeight:900,color:C.sky}}>{ort}</div>
        </div>
        <div style={{background:C.card,borderRadius:14,border:"1px solid "+C.borderLight,padding:"14px 18px",textAlign:"center"}}>
          <div style={{fontSize:10,fontWeight:700,color:C.textMuted,marginBottom:4}}>En Yuksek</div>
          <div style={{fontSize:26,fontWeight:900,color:C.amber}}>{maxK}</div>
        </div>
        {prog.filter(function(e){return e.durum==="eksik";}).length > 0 && <div style={{background:C.card,borderRadius:14,border:"1px solid "+C.coral+"30",padding:"14px 18px",textAlign:"center"}}>
          <div style={{fontSize:10,fontWeight:700,color:C.coral,marginBottom:4}}>Eksik Giris</div>
          <div style={{fontSize:26,fontWeight:900,color:C.coral}}>{prog.filter(function(e){return e.durum==="eksik";}).length}</div>
        </div>}
      </div>
      {chartData.length > 1 && (
        <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.borderLight,padding:20,marginBottom:18}}>
          <div style={{fontSize:14,fontWeight:700,marginBottom:14}}>Katilim Karsilastirmasi</div>
          <ResponsiveContainer width="100%" height={180}>
            <BarChart data={chartData}>
              <CartesianGrid strokeDasharray="3 3" stroke={C.borderLight}/>
              <XAxis dataKey="ad" tick={{fontSize:9,fill:C.textMuted}} axisLine={false} tickLine={false}/>
              <YAxis tick={{fontSize:10,fill:C.textMuted}} axisLine={false} tickLine={false}/>
              <Tooltip content={<CTooltip/>}/>
              <Bar dataKey="Mutlukent" name="Mutlukent" radius={[4,4,0,0]} fill={BOSTANLAR.mutlukent.renk}/>
              <Bar dataKey="Ata" name="Ata" radius={[4,4,0,0]} fill={BOSTANLAR.ata.renk}/>
              <Legend iconType="circle" iconSize={8} wrapperStyle={{fontSize:11}}/>
            </BarChart>
          </ResponsiveContainer>
        </div>
      )}
      <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.borderLight,overflow:"hidden"}}>
        <div style={{padding:"14px 18px",borderBottom:"1px solid "+C.borderLight,display:"flex",justifyContent:"space-between",alignItems:"center",flexWrap:"wrap",gap:8}}>
          <div style={{fontSize:14,fontWeight:700}}>Egitim Programi</div>
          <div style={{display:"flex",gap:6,alignItems:"center"}}>
            <Badge color={bRenk}>{bAd}</Badge>
            <span style={{fontSize:11,color:C.textMuted}}>{gun}</span>
          </div>
        </div>
        <div>
          {prog.map(function(e, i) {
            var sira = i + 1;
            var isEditing = editId === e.id;
            return (
              <div key={e.id} style={{display:"flex",alignItems:"center",gap:10,padding:"10px 18px",borderBottom:i < prog.length -1 ? "1px solid "+C.borderLight : "none",background:e.durum==="islendi" ? "transparent" : e.durum==="eksik" ? C.amber+"08" : C.bgWarm+"80",animation:"fadeUp .3s ease "+i*0.03+"s both"}}>
                <div style={{width:28,height:28,borderRadius:8,background:e.durum==="islendi" ? bRenk+"15" : e.durum==="eksik" ? C.amber+"15" : C.borderLight,display:"flex",alignItems:"center",justifyContent:"center",fontSize:11,fontWeight:900,color:e.durum==="islendi" ? bRenk : e.durum==="eksik" ? C.amber : C.textMuted,flexShrink:0}}>{sira}</div>
                <div style={{flex:1,minWidth:0}}>
                  <div style={{fontSize:12,fontWeight:700,color:e.durum==="islendi" ? C.text : e.durum==="eksik" ? C.amber : C.textSoft,overflow:"hidden",textOverflow:"ellipsis",whiteSpace:"nowrap"}}>{e.baslik}</div>
                  <div style={{fontSize:10,color:C.textMuted}}>{e.tarih}</div>
                </div>
                {e.durum==="islendi" && !isEditing && (
                  <div style={{display:"flex",alignItems:"center",gap:6,flexShrink:0}}>
                    <div style={{position:"relative",display:"flex",alignItems:"center",justifyContent:"center",cursor:rol==="yonetici"?"pointer":"default"}} onClick={function(ev){ev.stopPropagation();if(rol==="yonetici"){setEditId(e.id);setEditVal(String(e.katilim));}}}>
                      <svg width="36" height="42" viewBox="0 0 36 42"><ellipse cx="18" cy="16" rx="16" ry="14" fill={bRenk+"20"} stroke={bRenk} strokeWidth="1.5"/><path d={"M18 30 L16 42 M18 30 L20 42"} stroke={bRenk} strokeWidth="1" opacity="0.5"/><text x="18" y="19" textAnchor="middle" fontSize="11" fontWeight="800" fill={bRenk}>{e.katilim}</text></svg>
                    </div>
                    <Badge color={C.green1}>Islendi</Badge>
                    {rol === "yonetici" && <button onClick={function(){doSifirla(e.id);}} style={{background:"none",border:"none",cursor:"pointer",padding:2}} title="Sifirla"><Icon name="alert" size={12} color={C.coral}/></button>}
                  </div>
                )}
                {e.durum==="islendi" && isEditing && (
                  <div style={{display:"flex",alignItems:"center",gap:4,flexShrink:0}} onClick={function(ev){ev.stopPropagation();}}>
                    <input value={editVal} onChange={function(ev){setEditVal(ev.target.value);}} onKeyDown={function(ev){if(ev.key==="Enter")doKaydet(e.id);}} autoFocus style={{width:50,padding:"5px 8px",borderRadius:7,border:"1px solid "+bRenk,fontSize:12,fontWeight:700,textAlign:"center",outline:"none",fontFamily:"inherit"}}/>
                    <Btn small primary onClick={function(){doKaydet(e.id);}}>OK</Btn>
                    <button onClick={function(){setEditId(null);}} style={{background:"none",border:"none",cursor:"pointer",fontSize:14,color:C.textMuted}}>x</button>
                  </div>
                )}
                {e.durum==="eksik" && !isEditing && (
                  <div style={{display:"flex",alignItems:"center",gap:4,flexShrink:0}}>
                    <Badge color={C.amber}>Katilim Girilmedi</Badge>
                    {rol === "yonetici" && <button onClick={function(ev){ev.stopPropagation();setEditId(e.id);setEditVal("");}} style={{padding:"4px 10px",borderRadius:7,border:"1px solid "+bRenk,background:"transparent",color:bRenk,fontSize:10,fontWeight:700,cursor:"pointer"}}>Gir</button>}
                  </div>
                )}
                {e.durum==="eksik" && isEditing && (
                  <div style={{display:"flex",alignItems:"center",gap:4,flexShrink:0}} onClick={function(ev){ev.stopPropagation();}}>
                    <input value={editVal} onChange={function(ev){setEditVal(ev.target.value);}} onKeyDown={function(ev){if(ev.key==="Enter")doKaydet(e.id);}} autoFocus placeholder="Kisi" style={{width:50,padding:"5px 8px",borderRadius:7,border:"1px solid "+bRenk,fontSize:12,fontWeight:700,textAlign:"center",outline:"none",fontFamily:"inherit"}}/>
                    <Btn small primary onClick={function(){doKaydet(e.id);}}>Kaydet</Btn>
                    <button onClick={function(){setEditId(null);}} style={{background:"none",border:"none",cursor:"pointer",fontSize:14,color:C.textMuted}}>x</button>
                  </div>
                )}
                {e.durum==="bekliyor" && !isEditing && rol === "yonetici" && (
                  <button onClick={function(ev){ev.stopPropagation();setEditId(e.id);setEditVal("");}} style={{padding:"5px 12px",borderRadius:8,border:"1px solid "+bRenk,background:"transparent",color:bRenk,fontSize:11,fontWeight:700,cursor:"pointer"}}>Katilim Gir</button>
                )}
                {e.durum==="bekliyor" && !isEditing && rol !== "yonetici" && (
                  <Badge color={C.textMuted}>Bekliyor</Badge>
                )}
                {e.durum==="bekliyor" && isEditing && (
                  <div style={{display:"flex",alignItems:"center",gap:4,flexShrink:0}} onClick={function(ev){ev.stopPropagation();}}>
                    <input value={editVal} onChange={function(ev){setEditVal(ev.target.value);}} onKeyDown={function(ev){if(ev.key==="Enter")doKaydet(e.id);}} autoFocus placeholder="Kisi" style={{width:50,padding:"5px 8px",borderRadius:7,border:"1px solid "+bRenk,fontSize:12,fontWeight:700,textAlign:"center",outline:"none",fontFamily:"inherit"}}/>
                    <Btn small primary onClick={function(){doKaydet(e.id);}}>Kaydet</Btn>
                    <button onClick={function(){setEditId(null);}} style={{background:"none",border:"none",cursor:"pointer",fontSize:14,color:C.textMuted}}>x</button>
                  </div>
                )}
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
};

const Personel = ({bostan, rol, onEkle, onSil}) => {
  var b = BOSTANLAR[bostan];
  const [showAdd, setShowAdd] = useState(false);
  const [silId, setSilId] = useState(null);
  const [nP, setNP] = useState({ad:"",rol:"Bahce Sorumlusu",tel:""});
  var doAdd = function() {
    if (nP.ad.trim() && nP.tel.trim()) {
      onEkle(bostan, {id:Date.now(),ad:nP.ad,rol:nP.rol,tel:nP.tel,durum:"Aktif",izinKalan:14,izinler:[]});
      setNP({ad:"",rol:"Bahce Sorumlusu",tel:""});
      setShowAdd(false);
    }
  };
  var doSil = function() {
    if (silId !== null) { onSil(bostan, silId); setSilId(null); }
  };
  var silAd = silId !== null ? (b.personel.filter(function(p){return p.id===silId;})[0] || {}).ad || "" : "";
  return (
    <div>
      <div style={{display:"flex",justifyContent:"space-between",marginBottom:16}}>
        <h3 style={{margin:0,fontSize:15,fontWeight:700}}>{b.kisa} Personeli ({b.personel.length})</h3>
        {rol === "yonetici" && <Btn primary small icon="plus" onClick={function(){setShowAdd(!showAdd);}}>Ekle</Btn>}
      </div>
      {showAdd && (
        <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.green1+"40",padding:20,marginBottom:16,animation:"fadeUp .3s ease"}}>
          <div style={{fontSize:13,fontWeight:700,marginBottom:12,color:C.greenDark}}>Yeni Personel</div>
          <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(160px,1fr))",gap:10}}>
            <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Ad Soyad</label><input value={nP.ad} onChange={function(e){setNP({ad:e.target.value,rol:nP.rol,tel:nP.tel});}} style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Gorev</label><select value={nP.rol} onChange={function(e){setNP({ad:nP.ad,rol:e.target.value,tel:nP.tel});}} style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",background:"#fff"}}><option>Bahce Sorumlusu</option><option>Koordinator</option><option>Egitmen</option><option>Destek Personeli</option></select></div>
            <div><label style={{fontSize:10,fontWeight:700,color:C.textSoft,display:"block",marginBottom:3}}>Telefon</label><input value={nP.tel} onChange={function(e){setNP({ad:nP.ad,rol:nP.rol,tel:e.target.value});}} placeholder="05XX XXX XXXX" style={{width:"100%",padding:"8px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",boxSizing:"border-box",outline:"none"}}/></div>
          </div>
          <div style={{display:"flex",gap:8,marginTop:14}}>
            <Btn small primary onClick={doAdd}>Kaydet</Btn>
            <Btn small onClick={function(){setShowAdd(false);setNP({ad:"",rol:"Bahce Sorumlusu",tel:""});}}>Vazgec</Btn>
          </div>
        </div>
      )}
      <div style={{display:"grid",gap:12}}>
        {b.personel.map(function(p, i) { return (
          <div key={p.id} style={{background:C.card,borderRadius:16,border:"1px solid "+C.borderLight,padding:20,animation:"fadeUp .4s ease "+i*0.06+"s both"}}>
            <div style={{display:"flex",justifyContent:"space-between",flexWrap:"wrap",gap:8}}>
              <div style={{display:"flex",alignItems:"center",gap:12}}>
                <div style={{width:44,height:44,borderRadius:13,background:C.terra+"15",display:"flex",alignItems:"center",justifyContent:"center"}}><Icon name="person" size={20} color={C.terra}/></div>
                <div><div style={{fontSize:15,fontWeight:800}}>{p.ad}</div><div style={{fontSize:12,color:C.textSoft}}>{p.rol} - {p.tel}</div></div>
              </div>
              <div style={{display:"flex",gap:6,alignItems:"center"}}>
                <Badge color={C.green1}>{p.durum}</Badge>
                <Badge color={C.sky}>{p.izinKalan} gun izin</Badge>
                {rol === "yonetici" && <button onClick={function(){setSilId(p.id);}} style={{background:"none",border:"none",cursor:"pointer",padding:4,borderRadius:6}} title="Cikar"><Icon name="alert" size={14} color={C.coral}/></button>}
              </div>
            </div>
            {p.izinler.length > 0 && (
              <div style={{marginTop:14,padding:12,background:C.bgWarm,borderRadius:10}}>
                <div style={{fontSize:11,fontWeight:700,color:C.textSoft,marginBottom:6}}>Izin Gecmisi</div>
                {p.izinler.map(function(iz, j) { return (
                  <div key={j} style={{display:"flex",justifyContent:"space-between",padding:"5px 0",borderBottom:j < p.izinler.length-1 ? "1px solid "+C.borderLight : "none",fontSize:12}}>
                    <span>{iz.tarih} - {iz.gun} gun</span><Badge color={iz.durum==="Onayli" ? C.green1 : C.amber}>{iz.durum}</Badge>
                  </div>
                ); })}
              </div>
            )}
          </div>
        ); })}
      </div>
      {silId !== null && (
        <div style={{position:"fixed",inset:0,background:"rgba(0,0,0,0.4)",display:"flex",alignItems:"center",justifyContent:"center",zIndex:200,backdropFilter:"blur(3px)"}}>
          <div style={{background:C.card,borderRadius:20,padding:"28px 32px",maxWidth:380,width:"90%",boxShadow:"0 20px 60px rgba(0,0,0,0.2)",animation:"fadeUp 0.3s ease"}}>
            <div style={{display:"flex",alignItems:"center",gap:10,marginBottom:16}}>
              <div style={{width:42,height:42,borderRadius:12,background:C.coral+"15",display:"flex",alignItems:"center",justifyContent:"center"}}><Icon name="alert" size={22} color={C.coral}/></div>
              <div><div style={{fontSize:15,fontWeight:800,color:C.text}}>Personel Cikar</div><div style={{fontSize:12,color:C.textMuted}}>Bu islem geri alinamaz</div></div>
            </div>
            <div style={{padding:"14px 16px",background:C.coral+"08",borderRadius:12,marginBottom:18,fontSize:13,lineHeight:1.6,color:C.text}}>
              <b>{silAd}</b> isimli personeli cikarmak istediginize emin misiniz?
            </div>
            <div style={{display:"flex",gap:8,justifyContent:"flex-end"}}>
              <Btn small onClick={function(){setSilId(null);}}>Vazgec</Btn>
              <button onClick={doSil} style={{padding:"8px 20px",borderRadius:10,border:"none",background:"linear-gradient(135deg,"+C.coral+",#C62828)",color:"#fff",fontSize:12,fontWeight:700,cursor:"pointer",boxShadow:"0 2px 10px "+C.coral+"40"}}>Evet, Cikar</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

const SoruCevap = ({sorular, onCevapla, rol}) => {
  const [cId, setCId] = useState(null);
  const [cT, setCT] = useState("");
  var go = function(id) { if (cT.trim()) { onCevapla(id, cT); setCId(null); setCT(""); } };
  return (
    <div style={{display:"grid",gap:12}}>
      {sorular.map(function(s, i) { return (
        <div key={s.id} style={{background:C.card,borderRadius:16,border:"1px solid "+C.borderLight,padding:20,borderLeft:"4px solid "+(s.durum==="Bekliyor" ? C.amber : C.green1),animation:"fadeUp .4s ease "+i*0.06+"s both"}}>
          <div style={{display:"flex",justifyContent:"space-between",flexWrap:"wrap",gap:6,marginBottom:6}}>
            <div style={{fontSize:13,fontWeight:700}}>{s.gonderen} <Badge color={C.sky}>{BOSTANLAR[s.bostan] ? BOSTANLAR[s.bostan].kisa : ""}</Badge></div>
            <div style={{display:"flex",gap:6}}><span style={{fontSize:11,color:C.textMuted}}>{s.tarih}</span><Badge color={s.durum==="Bekliyor" ? C.amber : C.green1}>{s.durum}</Badge></div>
          </div>
          <div style={{fontSize:13,padding:"8px 12px",background:C.bgWarm,borderRadius:10,marginBottom:6,lineHeight:1.5}}>{s.soru}</div>
          {s.cevap && <div style={{fontSize:12,padding:"8px 12px",background:C.green5,borderRadius:10,marginBottom:6,color:C.greenDark}}>{s.cevap}</div>}
          {s.durum === "Bekliyor" && rol === "yonetici" && (
            cId === s.id ? (
              <div style={{display:"flex",gap:6,marginTop:6}}>
                <input value={cT} onChange={function(e){setCT(e.target.value);}} placeholder="Cevabin..." style={{flex:1,padding:"7px 12px",borderRadius:9,border:"1px solid "+C.border,fontSize:12,fontFamily:"inherit",outline:"none"}}/>
                <Btn small primary onClick={function(){go(s.id);}}>Gonder</Btn><Btn small onClick={function(){setCId(null);setCT("");}}>Iptal</Btn>
              </div>
            ) : (
              <Btn small icon="msg" onClick={function(){setCId(s.id);}}>Cevapla</Btn>
            )
          )}
        </div>
      ); })}
    </div>
  );
};

/* ====== BOSTANLAR SEVMESI ====== */
const BahceUyari = () => {
  const [month, setMonth] = useState(5);
  const [temp, setTemp] = useState(18);
  const [hum, setHum] = useState(60);
  const [selectedVeg, setSelectedVeg] = useState("");
  const [expandedId, setExpandedId] = useState(null);
  const [tab, setTab] = useState("dashboard");
  const [filter, setFilter] = useState("all");
  const [liveWeather, setLiveWeather] = useState(null);
  const [weatherLoading, setWeatherLoading] = useState(true);
  const [customTemp, setCustomTemp] = useState(null);
  const [customHum, setCustomHum] = useState(null);

  const ANKARA_CLIMATE = {3:{name:"Mart",avgTemp:5.5,humidity:62},4:{name:"Nisan",avgTemp:11.2,humidity:57},5:{name:"Mayıs",avgTemp:16.0,humidity:55},6:{name:"Haziran",avgTemp:20.2,humidity:48},7:{name:"Temmuz",avgTemp:23.5,humidity:38},8:{name:"Ağustos",avgTemp:23.3,humidity:38},9:{name:"Eylül",avgTemp:18.5,humidity:44}};
  
  // Hava durumu çek - ORIJINAL KOD
  useEffect(() => {
    function fetchWeather() {
      setWeatherLoading(true);
      fetch("https://api.open-meteo.com/v1/forecast?latitude=39.9334&longitude=32.8597&current=temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,rain&daily=temperature_2m_max,temperature_2m_min,relative_humidity_2m_mean,precipitation_sum&timezone=Europe%2FIstanbul&forecast_days=7")
        .then(r => r.json())
        .then(data => {
          console.log("API Yanıtı:", data);
          if (data.current) {
            const newWeather = {
              temp: Math.round(data.current.temperature_2m * 10) / 10,
              humidity: Math.round(data.current.relative_humidity_2m),
              feelsLike: Math.round(data.current.apparent_temperature * 10) / 10,
              wind: Math.round(data.current.wind_speed_10m),
              rain: Math.round((data.current.rain || 0) * 10) / 10
            };
            console.log("Hava durumu ayarlandı:", newWeather);
            setLiveWeather(newWeather);
            setTemp(Math.round(data.current.temperature_2m));
            setHum(Math.round(data.current.relative_humidity_2m));
          } else {
            // Fallback
            console.log("API'de current veri yok, fallback yapılıyor");
            setLiveWeather({temp: 20, humidity: 65, feelsLike: 19, wind: 8, rain: 0});
            setTemp(20);
            setHum(65);
          }
          setWeatherLoading(false);
        })
        .catch(err => {
          console.log("Hava durumu API hatası:", err);
          // Fallback - Demo verisi
          setLiveWeather({temp: 20, humidity: 65, feelsLike: 19, wind: 8, rain: 0});
          setTemp(20);
          setHum(65);
          setWeatherLoading(false);
        });
    }
    fetchWeather();
    var iv = setInterval(fetchWeather, 30 * 60 * 1000);
    return () => clearInterval(iv);
  }, []);

  const PESTS = [
    {id:"yaprak-biti",name:"Yaprak Biti",icon:"🐛",category:"böcek",targets:["Domates","Biber","Patılcan","Kabak","Salatalık"],peakMonths:[4,5,6],description:"Bitki özsuyunu emerek zayıflatır.",earlySign:"Yaprak altında küçük koloniler",prevention:"Sarı yapışkan tuzak",organic:"Sabunlu su, neem yağı",homemade:"5 diş sarımsak + 2 biber blenderdan, 1L suya karıştırın",interventionDays:7,riskCalc:(t,h)=>{let r=0;if(t>=15&&t<=28)r+=40;if(h>=40&&h<=70)r+=25;return Math.min(r,100);}},
    {id:"kirmizi-orumcek",name:"Kırmızı Örümcek",icon:"🕷️",category:"akar",targets:["Domates","Biber","Patılcan"],peakMonths:[6,7,8],description:"Sıcak havalarda hızla çoğalır.",earlySign:"Yaprak üstünde küçük sarı noktalar",prevention:"Yüksek nem",organic:"Neem yağı",homemade:"1 soğan kabuğu + 1L su demlendirin",interventionDays:5,riskCalc:(t,h)=>{let r=0;if(t>=25&&t<=35)r+=45;if(h>=10&&h<=50)r+=25;return Math.min(r,100);}},
    {id:"beyaz-sinek",name:"Beyaz Sinek",icon:"🥟",category:"böcek",targets:["Domates","Biber"],peakMonths:[5,6,7,8],description:"Bitki özsuyunu emer.",earlySign:"Yaprak altında beyaz sinekler",prevention:"Sarı yapışkan tuzak",organic:"Neem yağı",homemade:"1 yk deterjan + 1L su",interventionDays:5,riskCalc:(t,h)=>{let r=0;if(t>=20&&t<=32)r+=40;if(h>=50&&h<=80)r+=25;return Math.min(r,100);}}
  ];

  const DISEASES = [
    {id:"kulleme",name:"Külleme",icon:"🧿",category:"mantar",targets:["Kabak","Hıyar","Salatalık"],peakMonths:[5,6,7,8],description:"Beyaz-unumsu toz tabaması.",earlySign:"Yapraklarda beyaz lekeler",prevention:"Bitki arası mesafe",organic:"Süt-su karışımı",homemade:"4 bardak süt + 6 su",interventionDays:5,riskCalc:(t,h)=>{let r=0;if(t>=18&&t<=28)r+=40;if(h>=40&&h<=70)r+=25;return Math.min(r,100);}},
    {id:"mildioyu",name:"Mildiyu",icon:"🍂",category:"mantar",targets:["Salatalık","Kabak"],peakMonths:[4,5,6,9],description:"Yaprak altında gri-mor küf.",earlySign:"Yaprak damarları arası lekeler",prevention:"Sık dikim yapma",organic:"Bakırlı preparat",homemade:"1 bardak süt + 9 su haftada 2x",interventionDays:3,riskCalc:(t,h)=>{let r=0;if(t>=10&&t<=22)r+=35;if(h>=80)r+=30;return Math.min(r,100);}}
  ];

  const ALL_THREATS = [...PESTS, ...DISEASES];
  const ALL_VEGETABLES = [...new Set(ALL_THREATS.reduce((a,t)=>a.concat(t.targets),[]))].sort();

  const getRiskLevel = (s) => {
    if(s>=75) return {label:"ÇOK YÜKSEK",color:"#dc2626",bg:"#fef2f2",emoji:"🔴"};
    if(s>=55) return {label:"YÜKSEK",color:"#ea580c",bg:"#fff7ed",emoji:"🟠"};
    if(s>=35) return {label:"ORTA",color:"#ca8a04",bg:"#fefce8",emoji:"🟡"};
    if(s>=15) return {label:"DÜŞÜK",color:"#16a34a",bg:"#f0fdf4",emoji:"🟢"};
    return {label:"ÇOK DÜŞÜK",color:"#6b7280",bg:"#f9fafb",emoji:"⚪"};
  };

  const climate = ANKARA_CLIMATE[month];
  const displayTemp = customTemp !== null ? customTemp : temp;
  const displayHum = customHum !== null ? customHum : hum;
  const isLive = customTemp === null && customHum === null && liveWeather;

  const threats = ALL_THREATS.map(t => ({...t, risk: t.riskCalc(displayTemp, displayHum)}))
    .filter(t => !selectedVeg || t.targets.includes(selectedVeg))
    .filter(t => filter==="all" || (filter==="pest" && t.category!=="mantar" && t.category!=="bakteri") || (filter==="disease" && (t.category==="mantar" || t.category==="bakteri")))
    .sort((a,b) => b.risk - a.risk);

  const highRisk = threats.filter(t => t.risk>=55).length;

  return (
    <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.borderLight,padding:20}}>
      <div style={{marginBottom:20,padding:"16px",background:"linear-gradient(135deg, #1a2a1a, #2d3b2d)",borderRadius:12,border:"1px solid #3a4a3a",color:"#e8f0e8"}}>
        <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:12}}>
          <div>
            <div style={{fontSize:16,fontWeight:700,marginBottom:4}}>🌱 Ankara Sebze Bahçesi Erken Uyarı</div>
            <div style={{fontSize:12,opacity:0.7}}>Gerçek zamanlı hava durumu ve risk analizi</div>
          </div>
          {isLive && <div style={{background:"rgba(106,191,106,.2)",border:"1px solid rgba(106,191,106,.4)",borderRadius:20,padding:"4px 10px",fontSize:10,color:"#6abf6a",fontWeight:700}}>🟢 CANLI VERİ</div>}
        </div>
        {weatherLoading && <div style={{fontSize:12}}>⏳ Hava durumu yükleniyor...</div>}
        {liveWeather && <div style={{display:"grid",gridTemplateColumns:"repeat(3, 1fr)",gap:12}}>
          <div><div style={{fontSize:24,fontWeight:900}}>{liveWeather.temp}°C</div><div style={{fontSize:10,opacity:0.7}}>Sıcaklık</div></div>
          <div><div style={{fontSize:24,fontWeight:900}}>{liveWeather.humidity}%</div><div style={{fontSize:10,opacity:0.7}}>Nem</div></div>
          <div><div style={{fontSize:24,fontWeight:900}}>Ankara</div><div style={{fontSize:10,opacity:0.7}}>Konum</div></div>
        </div>}
      </div>

      {highRisk>0 && <div style={{background:"#dc262615",borderRadius:10,padding:"10px 16px",marginBottom:16,fontSize:13,fontWeight:600,color:"#dc2626"}}>🚨 {highRisk} yüksek riskli tehdit tespit edildi!</div>}

      <div style={{display:"flex",gap:8,flexWrap:"wrap",marginBottom:16}}>
        {Object.entries(ANKARA_CLIMATE).map(([m,c])=><button key={m} onClick={()=>setMonth(parseInt(m))} style={{padding:"8px 14px",borderRadius:8,border:"2px solid "+(parseInt(m)===month?C.greenDark:"#e5e7eb"),background:parseInt(m)===month?C.greenDark:"#fff",color:parseInt(m)===month?"#fff":C.text,fontWeight:600,cursor:"pointer",fontSize:12}}>{c.name}</button>)}
      </div>

      <div style={{display:"grid",gridTemplateColumns:"1fr 1fr",gap:12,marginBottom:16}}>
        <div><label style={{fontSize:12,fontWeight:600,color:C.textMuted}}>🌡️ Sıcaklık: {displayTemp}°C {isLive && "(canlı)"}</label><input type="range" min="0" max="42" step="0.5" value={displayTemp} onChange={(e)=>setCustomTemp(parseFloat(e.target.value))} style={{width:"100%",marginTop:4}}/></div>
        <div><label style={{fontSize:12,fontWeight:600,color:C.textMuted}}>💧 Nem: {displayHum}% {isLive && "(canlı)"}</label><input type="range" min="10" max="100" step="1" value={displayHum} onChange={(e)=>setCustomHum(parseInt(e.target.value))} style={{width:"100%",marginTop:4}}/></div>
      </div>

      {(customTemp !== null || customHum !== null) && <button onClick={()=>{setCustomTemp(null);setCustomHum(null);}} style={{padding:"8px 14px",borderRadius:8,background:C.green5,border:"1px solid "+C.green4,color:C.greenDark,fontWeight:600,cursor:"pointer",fontSize:12,marginBottom:16}}>↻ Canlı Verilere Dön</button>}

      <div style={{display:"flex",gap:8,flexWrap:"wrap",marginBottom:16}}>
        <select value={selectedVeg} onChange={(e)=>setSelectedVeg(e.target.value)} style={{padding:"8px 12px",borderRadius:8,border:"1px solid #d1d5db",fontSize:12,flex:1,minWidth:150}}>
          <option value="">🥬 Tüm Sebzeler</option>
          {ALL_VEGETABLES.map(v=><option key={v} value={v}>{v}</option>)}
        </select>
        {["all","pest","disease"].map(f=><button key={f} onClick={()=>setFilter(f)} style={{padding:"8px 12px",borderRadius:8,border:"2px solid "+(f===filter?C.greenDark:"#e5e7eb"),background:f===filter?C.greenDark:"#fff",color:f===filter?"#fff":C.text,fontWeight:600,cursor:"pointer",fontSize:12}}>{f==="all"?"Hepsi":f==="pest"?"🐛 Zararlı":"🦠 Hastalık"}</button>)}
        {["dashboard","calendar","plan"].map(t=><button key={t} onClick={()=>setTab(t)} style={{padding:"8px 12px",borderRadius:8,border:"2px solid "+(t===tab?C.greenDark:"#e5e7eb"),background:t===tab?C.greenDark:"#fff",color:t===tab?"#fff":C.text,fontWeight:600,cursor:"pointer",fontSize:12}}>{t==="dashboard"?"📊":"📅"}</button>)}
      </div>

      {tab==="dashboard" && (
        <div style={{display:"flex",flexDirection:"column",gap:10}}>
          {threats.slice(0,10).map(t=>{const lvl=getRiskLevel(t.risk);const isExp=expandedId===t.id;return (
            <div key={t.id} onClick={()=>setExpandedId(isExp?null:t.id)} style={{background:"#fff",borderRadius:10,border:"2px solid "+(t.risk>=55?lvl.color:"#e5e7eb"),padding:12,cursor:"pointer",boxShadow:t.risk>=75?"0 0 15px "+lvl.color+"30":"none"}}>
              <div style={{display:"flex",alignItems:"center",gap:10,marginBottom:8}}>
                <div style={{fontSize:24}}>{t.icon}</div>
                <div style={{flex:1}}>
                  <div style={{fontWeight:700,color:C.greenDark}}>{t.name}</div>
                  <div style={{fontSize:11,color:C.textMuted}}>{t.category} • {t.targets.slice(0,2).join(", ")}</div>
                </div>
                <div style={{background:lvl.bg,color:lvl.color,padding:"6px 12px",borderRadius:20,fontWeight:800,fontSize:12,border:"1px solid "+lvl.color+"30"}}>{lvl.emoji} {t.risk}%</div>
              </div>
              {isExp && (
                <div style={{background:"#f9fafb",borderRadius:8,padding:10,fontSize:12,lineHeight:1.6}}>
                  <p><strong>📋 {t.description}</strong></p>
                  <p><strong>🔍 Erken Belirti:</strong> {t.earlySign}</p>
                  <p><strong>✅ Önlem:</strong> {t.prevention}</p>
                  <p><strong>🌿 Doğal:</strong> {t.organic}</p>
                  <p><strong>🏠 Evsel Tarif:</strong> {t.homemade}</p>
                  {t.interventionDays>0 && <p><strong>⏱️ Müdahale:</strong> {t.interventionDays} gün içinde</p>}
                </div>
              )}
            </div>
          );})}
        </div>
      )}

      {tab==="calendar" && (
        <div style={{background:"#fff",borderRadius:10,padding:12,overflowX:"auto"}}>
          <table style={{width:"100%",fontSize:11,borderCollapse:"collapse"}}>
            <thead><tr style={{borderBottom:"2px solid "+C.greenDark}}><th style={{padding:6,textAlign:"left"}}>Tehdit</th>{[3,4,5,6,7,8,9].map(m=><th key={m} style={{padding:6,textAlign:"center"}}>{ANKARA_CLIMATE[m].name.slice(0,3)}</th>)}</tr></thead>
            <tbody>
              {threats.map(t=><tr key={t.id} style={{borderBottom:"1px solid #eee"}}><td style={{padding:6}}>{t.icon} {t.name}</td>{[3,4,5,6,7,8,9].map(m=>{const isPeak=t.peakMonths.includes(m);const risk=t.riskCalc(ANKARA_CLIMATE[m].avgTemp,ANKARA_CLIMATE[m].humidity);const lvl=getRiskLevel(risk);return <td key={m} style={{padding:6,textAlign:"center",background:isPeak?lvl.color+"15":"transparent",border:isPeak?"1px solid "+lvl.color:"transparent",borderRadius:4}}>{risk>10?risk:"—"}</td>;})}
              </tr>)}
            </tbody>
          </table>
        </div>
      )}

      {tab==="plan" && (
        <div style={{background:C.green5,borderRadius:10,padding:12,border:"1px solid "+C.green4}}>
          <div style={{fontWeight:700,marginBottom:8,color:C.greenDark}}>📋 Aksiyon Planı ({month}. ay - {displayTemp}°C, {displayHum}%)</div>
          {threats.filter(t=>t.risk>=35).slice(0,5).map(t=>{const lvl=getRiskLevel(t.risk);return (
            <div key={t.id} style={{background:"#fff",borderRadius:8,padding:10,marginBottom:8,borderLeft:"4px solid "+lvl.color}}>
              <div style={{fontWeight:700,color:C.greenDark}}>{t.icon} {t.name} - {lvl.emoji} {t.risk}% Risk</div>
              <div style={{fontSize:11,color:C.text,marginTop:4}}>→ {t.risk>=55?"ACIL MÜDAHALESİ ÖNERİLİR: ":"İZLEME: "} {t.homemade}</div>
            </div>
          )})}
        </div>
      )}
    </div>
  );
};

const Sevme = ({events}) => {
  var allK = BOSTANLAR.mutlukent.kursiyerler.concat(BOSTANLAR.ata.kursiyerler);
  var allP = BOSTANLAR.mutlukent.personel.concat(BOSTANLAR.ata.personel);
  var allE = BOSTANLAR.mutlukent.envanter.concat(BOSTANLAR.ata.envanter);
  var allPr = BOSTANLAR.mutlukent.parseller.concat(BOSTANLAR.ata.parseller);
  var allG = BOSTANLAR.mutlukent.gorevler.concat(BOSTANLAR.ata.gorevler);
  var tv = allE.reduce(function(s, e) { return s + e.stok * e.fiyat; }, 0);
  var hk = BOSTANLAR.mutlukent.hasat.map(function(h, i) {
    var ataVal = BOSTANLAR.ata.hasat[i] ? BOSTANLAR.ata.hasat[i].kg : 0;
    return {ay: h.ay, Mutlukent: h.kg, Ata: ataVal};
  });
  return (
    <div>
      <div style={{textAlign:"center",marginBottom:22}}>
        <div style={{fontSize:32,marginBottom:4}}>&#10084;&#65039;</div>
        <h2 style={{margin:0,fontSize:20,fontWeight:800,color:C.greenDark}}>Bostanlar Sevmesi</h2>
        <p style={{fontSize:12,color:C.textSoft,margin:"4px 0 0"}}>Tum bostanlarin toplu ozeti</p>
      </div>
      <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(170px,1fr))",gap:12,marginBottom:22}}>
        <StatCard icon="users" label="Toplam Kursiyer" value={allK.length} sub={allK.filter(function(k){return k.durum==="Aktif";}).length + " aktif"} color={C.green1}/>
        <StatCard icon="person" label="Personel" value={allP.length} color={C.terra} delay={0.05}/>
        <StatCard icon="grid" label="Parsel" value={allPr.length} sub={allPr.filter(function(p){return p.durum==="Dolu";}).length + " dolu"} color={C.sky} delay={0.1}/>
        <StatCard icon="box" label="Envanter" value={Math.round(tv/1000) + "K TL"} sub={allE.length + " kalem"} color={C.amber} delay={0.15}/>
        <StatCard icon="clipboard" label="Gorev" value={allG.length} color={C.coral} delay={0.2}/>
      </div>
      <div style={{display:"grid",gridTemplateColumns:"repeat(auto-fit,minmax(320px,1fr))",gap:16,marginBottom:16}}>
        <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.borderLight,padding:20}}>
          <div style={{fontSize:14,fontWeight:700,marginBottom:14}}>Hasat Karsilastirma (kg)</div>
          <ResponsiveContainer width="100%" height={200}>
            <BarChart data={hk} barCategoryGap="25%">
              <CartesianGrid strokeDasharray="3 3" stroke={C.borderLight}/><XAxis dataKey="ay" tick={{fontSize:11,fill:C.textMuted}} axisLine={false} tickLine={false}/><YAxis tick={{fontSize:11,fill:C.textMuted}} axisLine={false} tickLine={false}/><Tooltip content={<CTooltip/>}/><Legend iconType="circle" iconSize={8} wrapperStyle={{fontSize:11}}/>
              <Bar dataKey="Mutlukent" fill={C.green1} radius={[4,4,0,0]}/><Bar dataKey="Ata" fill={C.sky} radius={[4,4,0,0]}/>
            </BarChart>
          </ResponsiveContainer>
        </div>
        <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.borderLight,padding:20}}>
          <div style={{fontSize:14,fontWeight:700,marginBottom:14}}>Parsel Durumu (Toplam)</div>
          <ResponsiveContainer width="100%" height={200}>
            <PieChart>
              <Pie data={[{name:"Dolu",value:allPr.filter(function(p){return p.durum==="Dolu";}).length},{name:"Bos",value:allPr.filter(function(p){return p.durum==="Bos";}).length},{name:"Bakimda",value:allPr.filter(function(p){return p.durum==="Bakimda";}).length}]} cx="50%" cy="50%" innerRadius={50} outerRadius={75} paddingAngle={4} dataKey="value" strokeWidth={0}>
                <Cell fill={C.green1}/><Cell fill={C.border}/><Cell fill={C.amber}/>
              </Pie><Tooltip content={<CTooltip/>}/><Legend iconType="circle" iconSize={8} wrapperStyle={{fontSize:11}}/>
            </PieChart>
          </ResponsiveContainer>
        </div>
      </div>
      <div style={{background:C.card,borderRadius:16,border:"1px solid "+C.borderLight,overflow:"hidden"}}>
        <div style={{padding:"14px 18px",borderBottom:"1px solid "+C.borderLight,fontWeight:700,fontSize:14}}>Toplam Envanter</div>
        <div style={{overflowX:"auto"}}>
          <table style={{width:"100%",borderCollapse:"collapse",fontSize:13}}>
            <thead><tr style={{background:C.green5}}>{["Malzeme","Bostan","Kat.","Stok","Durum"].map(function(h){return <th key={h} style={{padding:"10px 12px",textAlign:"left",fontWeight:700,fontSize:11,color:C.greenDark}}>{h}</th>;})}</tr></thead>
            <tbody>{allE.map(function(e) {
              var bn = BOSTANLAR.mutlukent.envanter.indexOf(e) >= 0 ? "Mutlukent" : "Ata";
              var k = e.stok <= e.min;
              return (
                <tr key={e.id} style={{borderBottom:"1px solid "+C.borderLight,background:k ? C.coral+"04" : ""}}>
                  <td style={{padding:"10px 12px",fontWeight:700}}>{e.ad}</td>
                  <td style={{padding:"10px 12px"}}><Badge color={bn==="Mutlukent" ? C.green1 : C.sky}>{bn}</Badge></td>
                  <td style={{padding:"10px 12px"}}><Badge color={e.kat==="Tohum" ? C.green1 : e.kat==="Gubre" ? C.terra : C.sky}>{e.kat}</Badge></td>
                  <td style={{padding:"10px 12px",fontWeight:700,color:k ? C.coral : C.text}}>{e.stok} {e.birim}</td>
                  <td style={{padding:"10px 12px"}}><Badge color={k ? C.coral : C.green1}>{k ? "Kritik" : "Yeterli"}</Badge></td>
                </tr>
              );
            })}</tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

const AIAsistan = ({bostan, events, rol}) => {
  var kursiyerMi = rol === "kursiyer";
  const [mesajlar, setMesajlar] = useState([{rol:"ai",text:kursiyerMi ? "Merhaba! Ben Kent Bostanlari Egitim Asistaniyim. Egitim programi, sebze yetistiriciligi, terraryum, parsel bakimi ve dogal yontemler hakkinda sorularinizi yanıtlayabilirim.\n\nOrnek sorular:\n- Domates ne zaman ekilir?\n- Terraryum nasil yapilir?\n- Yaprak biti icin ne yapmaliyim?\n- Gelecek egitim ne zaman?" : "Merhaba! Ben Kent Bostanlari AI Asistaniyim. Egitim programi, ekim plani, parseller, envanter, takvim ve teknik rehber hakkinda sorularinizi yanıtlayabilirim.\n\nOrnek sorular:\n- Domates ne zaman ekilir?\n- Kulleme hastaligi ile nasil mucadele edilir?\n- 10m2 alan icin bahar plani nedir?\n- Hangi parseller bos?\n- Bu hafta hangi egitimler var?"}]);
  const [input, setInput] = useState("");
  const [yukleniyor, setYukleniyor] = useState(false);
  const chatRef = useRef(null);

  var baglamOlustur = function() {
    var b = BOSTANLAR[bostan];
    var bAd = b ? b.kisa : "";
    var metin = "KENT BOSTANLARI " + (kursiyerMi ? "EGITIM ASISTANI" : "YONETIM SISTEMI") + " VERILERI\n\n";
    metin += "BUGUNKU TARIH: " + new Date().toLocaleDateString("tr-TR", {weekday:"long", year:"numeric", month:"long", day:"numeric"}) + "\n";
    metin += "Secili Bostan: " + bAd + "\n\n";

    metin += "=== EGITIM PROGRAMI ===\n";
    var bugunAI = new Date().toISOString().slice(0,10);
    metin += "MUTLUKENT (Carsamba 12:30-14:30):\n";
    EGITIM_PROGRAMI.mutlukent.forEach(function(e,i){
      var gecmis = e.iso <= bugunAI;
      var durum = gecmis ? "Yapildi" + (e.katilim > 0 ? " ("+e.katilim+" kisi katildi)" : "") : "Henuz yapilmadi (gelecek tarih)";
      metin += (i+1) + ". " + e.baslik + " | " + e.tarih + " (" + e.iso + ") | " + durum + "\n";
    });
    metin += "\nATA KENT (Persembe 13:00-15:00):\n";
    EGITIM_PROGRAMI.ata.forEach(function(e,i){
      var gecmis = e.iso <= bugunAI;
      var durum = gecmis ? "Yapildi" + (e.katilim > 0 ? " ("+e.katilim+" kisi katildi)" : "") : "Henuz yapilmadi (gelecek tarih)";
      metin += (i+1) + ". " + e.baslik + " | " + e.tarih + " (" + e.iso + ") | " + durum + "\n";
    });

    if (!kursiyerMi) {
      metin += "\n=== PARSELLER ===\n";
      metin += "Mutlukent (36 parsel):\n";
      BOSTANLAR.mutlukent.parseller.forEach(function(p){
        metin += "Parsel " + p.id + ": " + p.durum + (p.kursiyer !== "-" ? " | Kursiyer: " + p.kursiyer : "") + (p.urun !== "-" ? " | Urun: " + p.urun : "") + "\n";
      });
      metin += "\nAta Kent (8 parsel):\n";
      BOSTANLAR.ata.parseller.forEach(function(p){
        metin += "Parsel " + p.id + ": " + p.durum + (p.kursiyer !== "-" ? " | Kursiyer: " + p.kursiyer : "") + (p.urun !== "-" ? " | Urun: " + p.urun : "") + "\n";
      });

      metin += "\n=== ENVANTER ===\n";
      ["mutlukent","ata"].forEach(function(bk){
        metin += BOSTANLAR[bk].kisa + ":\n";
        BOSTANLAR[bk].envanter.forEach(function(e){
          metin += "- " + e.ad + " | " + e.kat + " | Stok: " + e.stok + " " + e.birim + " | Min: " + e.min + " | " + e.konum + (e.stok <= e.min ? " [KRITIK]" : "") + "\n";
        });
      });

      metin += "\n=== GOREVLER ===\n";
      ["mutlukent","ata"].forEach(function(bk){
        metin += BOSTANLAR[bk].kisa + ":\n";
        BOSTANLAR[bk].gorevler.forEach(function(g){
          metin += "- " + g.baslik + " | " + g.atanan + " | " + g.oncelik + " | " + g.durum + " | " + g.tarih + "\n";
        });
      });

      metin += "\n=== PERSONEL ===\n";
      ["mutlukent","ata"].forEach(function(bk){
        metin += BOSTANLAR[bk].kisa + ":\n";
        BOSTANLAR[bk].personel.forEach(function(p){
          metin += "- " + p.ad + " | " + p.rol + " | " + p.durum + " | " + p.izinKalan + " gun izin kalan\n";
        });
      });

      metin += "\n=== KURSIYERLER ===\n";
      ["mutlukent","ata"].forEach(function(bk){
        metin += BOSTANLAR[bk].kisa + ":\n";
        BOSTANLAR[bk].kursiyerler.forEach(function(k){
          metin += "- " + k.ad + " | Parsel: " + k.parsel + " | " + k.durum + "\n";
        });
      });

      metin += "\n=== TAKVIM ETKINLIKLERI (yaklasan) ===\n";
      var simdi = new Date().toISOString().slice(0,10);
      events.filter(function(e){return e.tarih >= simdi;}).sort(function(a,b){return a.tarih > b.tarih ? 1 : -1;}).slice(0,20).forEach(function(e){
        metin += "- " + e.tarih + " " + e.saat + " | " + e.baslik + " | " + e.tip + " | " + (BOSTANLAR[e.bostan] ? BOSTANLAR[e.bostan].kisa : "") + "\n";
      });

      metin += "\n=== TATILLER ===\n";
      Object.keys(TATILLER).forEach(function(t){
        metin += t + ": " + TATILLER[t] + "\n";
      });
    }

    metin += "\n=== TEKNIK REHBER VE DOKUMAN BILGISI ===\n";
    metin += BILGI_TABANI;
    return metin;
  };

  var gonder = function() {
    if (!input.trim() || yukleniyor) return;
    var soru = input.trim();
    setInput("");
    setMesajlar(function(p){return p.concat([{rol:"user",text:soru}]);});
    setYukleniyor(true);

    var baglam = baglamOlustur();
    fetch("https://api.anthropic.com/v1/messages", {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify({
        model: "claude-sonnet-4-20250514",
        max_tokens: 1000,
        system: kursiyerMi ? "Sen Cankaya Belediyesi Kent Bostanlari egitim asistanisin. Kursiyerlere yardimci oluyorsun. Sana verilen egitim programi ve teknik rehber dokumanlarina dayanarak sorulari yanitla. Turkce cevap ver. Kisa, samimi ve anlasilir ol. Verilerde olmayan bilgiyi uydurma. ONEMLI: Egitim tarihi bugunden once ise o egitim YAPILMISTIR. Sebze yetistiriciligi, ekim-dikim, gubre, hastalik mucadelesi, terraryum, parsel bakimi gibi egitim konularinda detayli bilgi ver. Parsel, envanter, personel, gorev gibi yonetim bilgilerini PAYLASMA, bu bilgiler sende yok." : "Sen Cankaya Belediyesi Kent Bostanlari yonetim sisteminin AI asistanisin. Sana verilen gercek verilere dayanarak sorulari yanitla. Turkce cevap ver. Kisa ve net ol. Verilerde olmayan bilgiyi uydurma. Sayisal sorularda hesaplama yap. ONEMLI KURALLAR: 1) Egitim tarihi bugunden once ise o egitim YAPILMISTIR. 2) Teknik Rehber dokumanlarina dayanarak sebze yetistiriciligi, gubre, hastalik, zararli mucadelesi gibi sorulari yanitla. 3) 10m2 bahar plani, terraryum, parsel rehberi hakkinda bilgi ver.",
        messages: [
          {role: "user", content: "SISTEM VERILERI:\n\n" + baglam + "\n\nKULLANICI SORUSU: " + soru}
        ]
      })
    }).then(function(response) {
      return response.json();
    }).then(function(data) {
      var cevap = data.content && data.content[0] ? data.content[0].text : "Bir hata olustu, tekrar deneyin.";
      setMesajlar(function(p){return p.concat([{rol:"ai",text:cevap}]);});
      setYukleniyor(false);
    }).catch(function(err) {
      setMesajlar(function(p){return p.concat([{rol:"ai",text:"Baglanti hatasi. Lutfen tekrar deneyin."}]);});
      setYukleniyor(false);
    });
  };

  useEffect(function(){
    if(chatRef.current) chatRef.current.scrollTop = chatRef.current.scrollHeight;
  }, [mesajlar, yukleniyor]);

  return (
    <div style={{display:"flex",flexDirection:"column",height:"calc(100vh - 180px)",maxHeight:600}}>
      <div ref={chatRef} style={{flex:1,overflowY:"auto",display:"flex",flexDirection:"column",gap:10,padding:"10px 0",marginBottom:12}}>
        {mesajlar.map(function(m, i) {
          var isAI = m.rol === "ai";
          return (
            <div key={i} style={{display:"flex",justifyContent:isAI ? "flex-start" : "flex-end",animation:"fadeUp .3s ease"}}>
              <div style={{maxWidth:"85%",padding:"12px 16px",borderRadius:isAI ? "4px 16px 16px 16px" : "16px 4px 16px 16px",background:isAI ? C.card : "linear-gradient(135deg,"+C.green1+","+C.greenDark+")",color:isAI ? C.text : "#fff",border:isAI ? "1px solid "+C.borderLight : "none",fontSize:13,lineHeight:1.6,whiteSpace:"pre-wrap",boxShadow:isAI ? "0 2px 8px rgba(0,0,0,0.04)" : "0 2px 12px "+C.green1+"30"}}>
                {isAI && i === 0 && <div style={{display:"flex",alignItems:"center",gap:6,marginBottom:6}}><div style={{width:22,height:22,borderRadius:7,background:C.green1+"15",display:"flex",alignItems:"center",justifyContent:"center"}}><Icon name="msg" size={12} color={C.green1}/></div><span style={{fontSize:11,fontWeight:800,color:C.green1}}>{kursiyerMi ? "Egitim AI" : "Bostan AI"}</span></div>}
                {m.text}
              </div>
            </div>
          );
        })}
        {yukleniyor && (
          <div style={{display:"flex",justifyContent:"flex-start"}}>
            <div style={{padding:"12px 20px",borderRadius:"4px 16px 16px 16px",background:C.card,border:"1px solid "+C.borderLight}}>
              <div style={{display:"flex",gap:4}}>
                <span style={{width:6,height:6,borderRadius:"50%",background:C.green1,animation:"fadeUp .6s ease infinite alternate"}}/>
                <span style={{width:6,height:6,borderRadius:"50%",background:C.green1,animation:"fadeUp .6s ease .2s infinite alternate"}}/>
                <span style={{width:6,height:6,borderRadius:"50%",background:C.green1,animation:"fadeUp .6s ease .4s infinite alternate"}}/>
              </div>
            </div>
          </div>
        )}
      </div>
      <div style={{display:"flex",gap:8,alignItems:"center"}}>
        <input value={input} onChange={function(e){setInput(e.target.value);}} onKeyDown={function(e){if(e.key==="Enter") gonder();}} placeholder="Orn: Mart'ta hangi egitimler var? Bos parseller hangileri?..." style={{flex:1,padding:"12px 16px",borderRadius:14,border:"1px solid "+C.border,fontSize:13,fontFamily:"inherit",outline:"none",background:C.card}}/>
        <button onClick={gonder} disabled={yukleniyor || !input.trim()} style={{width:44,height:44,borderRadius:14,border:"none",background:"linear-gradient(135deg,"+C.green1+","+C.greenDark+")",cursor:"pointer",display:"flex",alignItems:"center",justifyContent:"center",opacity:yukleniyor || !input.trim() ? 0.5 : 1,flexShrink:0}}><Icon name="msg" size={18} color="#fff"/></button>
      </div>
      <div style={{display:"flex",gap:6,marginTop:8,flexWrap:"wrap"}}>
        {(kursiyerMi ? ["Gelecek egitim?","Domates nasil ekilir?","Terraryum nedir?","Yaprak biti ilaci?","Parsel bakim rehberi?","Kompost nasil yapilir?"] : ["Bos parseller?","Bu hafta ne var?","Kritik stok?","Domates ne zaman ekilir?","Terraryum nasil yapilir?","Parsel bakim rehberi?"]).map(function(s){
          return <button key={s} onClick={function(){setInput(s);}} style={{padding:"5px 10px",borderRadius:8,border:"1px solid "+C.borderLight,background:C.bgWarm,fontSize:10,fontWeight:600,color:C.textSoft,cursor:"pointer"}}>{s}</button>;
        })}
      </div>
    </div>
  );
};

const Bildirimler = ({events, bostan}) => {
  var fe = events.filter(function(e) { return e.bildirim && (!bostan || bostan === "hepsi" || e.bostan === bostan); });
  return (
    <div style={{display:"grid",gap:10}}>
      {fe.length === 0 && <div style={{textAlign:"center",padding:40,color:C.textMuted}}>Henuz bildirim yok.</div>}
      {fe.map(function(e, i) { return (
        <div key={e.id} style={{background:C.card,borderRadius:14,border:"1px solid "+C.borderLight,padding:"14px 18px",display:"flex",alignItems:"center",gap:12,animation:"fadeUp .4s ease "+i*0.04+"s both"}}>
          <div style={{width:38,height:38,borderRadius:11,background:(({egitim:C.sky,ekim:"#66BB6A",dikim:C.amber,besleme:"#AB47BC",gorev:C.terra,etkinlik:C.green1})[e.tip] || C.green1)+"15",display:"flex",alignItems:"center",justifyContent:"center"}}><Icon name={e.tip==="egitim" ? "calendar" : e.tip==="ekim" ? "box" : e.tip==="besleme" ? "chart" : "bell"} size={18} color={({egitim:C.sky,ekim:"#66BB6A",dikim:C.amber,besleme:"#AB47BC",gorev:C.terra,etkinlik:C.green1})[e.tip] || C.green1}/></div>
          <div style={{flex:1}}>
            <div style={{fontSize:13,fontWeight:700}}>{e.baslik}</div>
            <div style={{fontSize:11,color:C.textMuted}}>{e.tarih} - {e.saat} - {BOSTANLAR[e.bostan] ? BOSTANLAR[e.bostan].kisa : ""}</div>
          </div>
          <Badge color={({egitim:C.sky,ekim:"#66BB6A",dikim:C.amber,besleme:"#AB47BC",gorev:C.terra,etkinlik:C.green1})[e.tip] || C.green1}>{({egitim:"Egitim",ekim:"Ekim",dikim:"Dikim",besleme:"Besleme",gorev:"Gorev",etkinlik:"Etkinlik",tatil:"Tatil"}[e.tip] || e.tip)}</Badge>
        </div>
      ); })}
    </div>
  );
};

/* ====== MAIN APP ====== */
export default function App() {
  const [user, setUser] = useState(null);
  const [page, setPage] = useState("dashboard");
  const [bostan, setBostan] = useState("mutlukent");
  const [sbOpen, setSbOpen] = useState(false);
  const [mob, setMob] = useState(false);
  const [events, setEvents] = useState(initEvents);
  const [sorular, setSorular] = useState(initSorular);
  const [toast, setToast] = useState(null);
  const [saat, setSaat] = useState(new Date());
  const [havaDurumu, setHavaDurumu] = useState(null);
  const [havaAcik, setHavaAcik] = useState(false);

  useEffect(function() {
    var c = function() { setMob(window.innerWidth < 768); };
    c();
    window.addEventListener("resize", c);
    return function() { window.removeEventListener("resize", c); };
  }, []);

  // Saat güncelle her saniye
  useEffect(function() {
    var interval = setInterval(function() {
      setSaat(new Date());
    }, 1000);
    return function() { clearInterval(interval); };
  }, []);

  // Hava durumu çek
  useEffect(function() {
    // Netlify'de: /api/weather
    // Local'de: /netlify/functions/weather
    var apiUrl = window.location.hostname === 'localhost' 
      ? '/netlify/functions/weather'
      : '/api/weather';
    
    fetch(apiUrl)
      .then(r => r.json())
      .then(data => {
        if(data.current && data.daily) {
          var gunler = [];
          for(var i = 0; i < 7 && i < data.daily.time.length; i++) {
            gunler.push({
              tarih: data.daily.time[i],
              maxTemp: Math.round(data.daily.temperature_2m_max[i]),
              minTemp: Math.round(data.daily.temperature_2m_min[i]),
              nem: data.daily.relative_humidity_2m_max[i],
              ruzgar: Math.round(data.daily.wind_speed_10m_max[i])
            });
          }
          setHavaDurumu({
            temp: Math.round(data.current.temperature_2m),
            humidity: Math.round(data.current.relative_humidity_2m),
            ruzgar: Math.round(data.current.wind_speed_10m),
            gunler: gunler
          });
        }
      })
      .catch(err => {
        console.log("Hava durumu hatası:", err);
        setHavaDurumu({
          temp: 20, 
          humidity: 65, 
          ruzgar: 8,
          gunler: [
            {tarih: "2025-03-18", maxTemp: 22, minTemp: 14, nem: 65, ruzgar: 10},
            {tarih: "2025-03-19", maxTemp: 21, minTemp: 13, nem: 62, ruzgar: 12},
            {tarih: "2025-03-20", maxTemp: 23, minTemp: 15, nem: 58, ruzgar: 9},
            {tarih: "2025-03-21", maxTemp: 19, minTemp: 11, nem: 72, ruzgar: 15},
            {tarih: "2025-03-22", maxTemp: 20, minTemp: 10, nem: 75, ruzgar: 18},
            {tarih: "2025-03-23", maxTemp: 21, minTemp: 12, nem: 68, ruzgar: 11},
            {tarih: "2025-03-24", maxTemp: 24, minTemp: 16, nem: 60, ruzgar: 8}
          ]
        });
      });
  }, []);

  var addEvt = function(e) {
    setEvents(function(p) { return p.concat([e]); });
    setToast(e.bildirim ? "Kursiyerlere bildirim gonderildi!" : "Takvime eklendi!");
    setTimeout(function() { setToast(null); }, 2500);
  };
  var cevapla = function(id, c) {
    setSorular(function(p) { return p.map(function(s) { return s.id === id ? {id:s.id, gonderen:s.gonderen, bostan:s.bostan, soru:s.soru, tarih:s.tarih, cevap:c, durum:"Cevaplandi"} : s; }); });
  };
  var silKursiyer = function(bKey, kId) {
    BOSTANLAR[bKey].kursiyerler = BOSTANLAR[bKey].kursiyerler.filter(function(k){return k.id !== kId;});
    setToast("Kursiyer silindi!");
    setTimeout(function(){setToast(null);}, 2500);
    setEvents(function(p){return p.concat([]);});
  };
  var eklePersonel = function(bKey, p) {
    BOSTANLAR[bKey].personel = BOSTANLAR[bKey].personel.concat([p]);
    setToast(p.ad + " eklendi!");
    setTimeout(function(){setToast(null);}, 2500);
    setEvents(function(pr){return pr.concat([]);});
  };
  var silPersonel = function(bKey, pId) {
    BOSTANLAR[bKey].personel = BOSTANLAR[bKey].personel.filter(function(p){return p.id !== pId;});
    setToast("Personel cikarildi!");
    setTimeout(function(){setToast(null);}, 2500);
    setEvents(function(pr){return pr.concat([]);});
  };
  var ekleGorev = function(bKey, g) {
    BOSTANLAR[bKey].gorevler = BOSTANLAR[bKey].gorevler.concat([g]);
    setToast("Gorev eklendi!");
    setTimeout(function(){setToast(null);}, 2500);
    setEvents(function(pr){return pr.concat([]);});
  };
  var silGorev = function(bKey, gId) {
    BOSTANLAR[bKey].gorevler = BOSTANLAR[bKey].gorevler.filter(function(g){return g.id !== gId;});
    setToast("Gorev silindi!");
    setTimeout(function(){setToast(null);}, 2500);
    setEvents(function(pr){return pr.concat([]);});
  };
  var gorevTakvimeGonder = function(bKey, baslik, tarih, saat) {
    var yeniEvt = {id:"g-"+Date.now(), tarih:tarih, saat:saat, baslik:baslik, tip:"gorev", bostan:bKey, bildirim:false};
    setEvents(function(p){return p.concat([yeniEvt]);});
    setToast("Takvime eklendi: " + baslik);
    setTimeout(function(){setToast(null);}, 2500);
  };
  var urunGuncelle = function(bKey, pId, yeniUrun) {
    BOSTANLAR[bKey].parseller = BOSTANLAR[bKey].parseller.map(function(p) {
      if (p.id === pId) { return {id:p.id, kursiyer:p.kursiyer, urun:yeniUrun, ekim:p.ekim, durum: yeniUrun === "-" ? "Bos" : "Dolu"}; }
      return p;
    });
    setToast("Parsel guncellendi!");
    setTimeout(function(){setToast(null);}, 2500);
    setEvents(function(pr){return pr.concat([]);});
  };
  var silEnvanter = function(bKey, eId) {
    BOSTANLAR[bKey].envanter = BOSTANLAR[bKey].envanter.filter(function(e){return e.id !== eId;});
    setToast("Malzeme silindi!");
    setTimeout(function(){setToast(null);}, 2500);
    setEvents(function(pr){return pr.concat([]);});
  };
  var ekleEnvanter = function(bKey, e) {
    BOSTANLAR[bKey].envanter = BOSTANLAR[bKey].envanter.concat([e]);
    setToast(e.ad + " eklendi!");
    setTimeout(function(){setToast(null);}, 2500);
    setEvents(function(pr){return pr.concat([]);});
  };
  const [stokLog, setStokLog] = useState([]);
  var stokGuncelle = function(bKey, eId, yeniStok, logEntry) {
    BOSTANLAR[bKey].envanter = BOSTANLAR[bKey].envanter.map(function(e) {
      if (e.id === eId) return {id:e.id,ad:e.ad,kat:e.kat,stok:yeniStok,min:e.min,birim:e.birim,fiyat:e.fiyat,konum:e.konum};
      return e;
    });
    if (logEntry) {
      setStokLog(function(prev) { return prev.concat([{envId:eId, bostan:bKey, tarih:logEntry.tarih, miktar:logEntry.miktar, tip:logEntry.tip, neden:logEntry.neden, not:logEntry.not, ad:logEntry.ad, birim:logEntry.birim}]); });
      setToast((logEntry.tip==="eksilt" ? "Stok dusuruldu: " : "Stok eklendi: ") + logEntry.miktar + " " + logEntry.birim);
      setTimeout(function(){setToast(null);}, 2500);
    }
    setEvents(function(pr){return pr.concat([]);});
  };

  if (!user) return <LoginPage onLogin={setUser}/>;

  var yPages = [{id:"dashboard",l:"Ana Panel",i:"home"},{id:"kursiyerler",l:"Kursiyerler",i:"users"},{id:"personel",l:"Personel",i:"person"},{id:"gorevler",l:"Is Takibi",i:"clipboard"},{id:"parseller",l:"Parseller",i:"grid"},{id:"envanter",l:"Envanter",i:"box"},{id:"kurslar",l:"Kurslar",i:"calendar"},{id:"sorular",l:"Soru & Cevap",i:"msg"},{id:"bahce-uyari",l:"Bahce Uyari",i:"alert"},{id:"sevme",l:"Bostanlar Sevmesi",i:"heart"},{id:"asistan",l:"AI Asistan",i:"msg"}];
  var pPages = [{id:"dashboard",l:"Ana Panel",i:"home"},{id:"gorevler",l:"Is Takibi",i:"clipboard"},{id:"parseller",l:"Parseller",i:"grid"},{id:"envanter",l:"Envanter",i:"box"},{id:"sorular",l:"Soru Gonder",i:"msg"},{id:"asistan",l:"AI Asistan",i:"msg"}];
  var kPages = [{id:"dashboard",l:"Ana Panel",i:"home"},{id:"parseller",l:"Parselim",i:"grid"},{id:"kurslar",l:"Kurslarim",i:"calendar"},{id:"bildirimler",l:"Bildirimler",i:"bell"},{id:"asistan",l:"Egitim Asistani",i:"msg"}];
  var pages = user === "yonetici" ? yPages : user === "personel" ? pPages : kPages;

  var titles = {dashboard:"Ana Panel",kursiyerler:"Kursiyer Yonetimi",personel:"Personel Yonetimi",gorevler:"Is & Gorev Takibi",parseller:"Parsel Yonetimi",envanter:"Envanter & Malzeme",kurslar:"Kurs & Etkinlikler",sorular:user==="yonetici" ? "Soru & Cevap" : "Soru Gonder","bahce-uyari":"Bahce Uyari Sistemi",sevme:"Bostanlar Sevmesi",bildirimler:"Bildirimler",asistan:user==="kursiyer" ? "Egitim Asistani" : "AI Asistan"};

  var renderPage = function() {
    switch(page) {
      case "kursiyerler": return <Kursiyerler bostan={bostan} rol={user} onSil={silKursiyer}/>;
      case "personel": return <Personel bostan={bostan} rol={user} onEkle={eklePersonel} onSil={silPersonel}/>;
      case "gorevler": return <Gorevler bostan={bostan} rol={user} onEkle={ekleGorev} onSil={silGorev} onTakvimeGonder={gorevTakvimeGonder}/>;
      case "parseller": return <Parseller bostan={bostan} rol={user} onUrunGuncelle={urunGuncelle}/>;
      case "envanter": return <Envanter bostan={bostan} rol={user} onSil={silEnvanter} onEkle={ekleEnvanter} onStokGuncelle={stokGuncelle} stokLog={stokLog}/>;
      case "kurslar": return <Kurslar bostan={bostan} rol={user}/>;
      case "sorular": return <SoruCevap sorular={sorular.filter(function(s){return s.bostan===bostan;})} onCevapla={cevapla} rol={user}/>;
      case "bahce-uyari": return <BahceUyari/>;
      case "sevme": return <Sevme events={events}/>;
      case "asistan": return <AIAsistan bostan={bostan} events={events} rol={user}/>;
      case "bildirimler": return <Bildirimler events={events} bostan={bostan}/>;
      default: return <Dash bostan={bostan} events={events} onAdd={addEvt} rol={user}/>;
    }
  };

  var rL = user === "yonetici" ? "Yonetici" : user === "personel" ? "Personel" : "Kursiyer";
  var rC = user === "yonetici" ? C.greenDark : user === "personel" ? C.terra : C.sky;

  return (
    <div style={{fontFamily:"'DM Sans',sans-serif",background:C.bg,minHeight:"100vh",display:"flex",color:C.text}}>
      <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
      <style>{"@keyframes fadeUp{from{opacity:0;transform:translateY(12px)}to{opacity:1;transform:translateY(0)}}::-webkit-scrollbar{width:5px}::-webkit-scrollbar-thumb{background:"+C.border+";border-radius:3px}*{box-sizing:border-box}"}</style>

      {sbOpen && mob && <div onClick={function(){setSbOpen(false);}} style={{position:"fixed",inset:0,background:"rgba(0,0,0,0.35)",zIndex:40,backdropFilter:"blur(2px)"}}/>}

      <aside style={{width:250,background:"linear-gradient(180deg,"+C.greenDeep+",#14451A)",color:"#fff",display:"flex",flexDirection:"column",position:mob ? "fixed" : "relative",height:"100vh",zIndex:50,transform:mob && !sbOpen ? "translateX(-100%)" : "none",transition:"transform .3s cubic-bezier(.4,0,.2,1)"}}>
        <div style={{padding:"22px 18px 18px",borderBottom:"1px solid rgba(255,255,255,0.08)"}}>
          <div style={{display:"flex",alignItems:"center",gap:10}}>
            <div style={{width:38,height:38,borderRadius:11,background:"linear-gradient(135deg,"+C.green1+","+C.green3+")",display:"flex",alignItems:"center",justifyContent:"center",fontSize:18}}>&#127807;</div>
            <div><div style={{fontSize:14,fontWeight:800}}>Kent Bostanlari</div><div style={{fontSize:10,opacity:0.5}}>Cankaya Belediyesi</div></div>
          </div>
          <div style={{marginTop:12,padding:"7px 10px",background:rC+"30",borderRadius:8,display:"flex",alignItems:"center",gap:6}}>
            <div style={{width:7,height:7,borderRadius:"50%",background:rC}}/><span style={{fontSize:11,fontWeight:700}}>{rL} Girisi</span>
          </div>
        </div>
        <nav style={{padding:"10px 10px",flex:1,overflowY:"auto"}}>
          {pages.map(function(pg) {
            var a = page === pg.id;
            var sev = pg.id === "sevme";
            return (
              <button key={pg.id} onClick={function(){setPage(pg.id);setSbOpen(false);}} style={{display:"flex",alignItems:"center",gap:10,width:"100%",padding:"11px 14px",borderRadius:10,border:"none",background:a ? "rgba(16,185,129,0.25)" : sev ? "rgba(239,68,68,0.1)" : "transparent",color:a ? "#fff" : sev ? "#fca5a5" : "rgba(255,255,255,0.65)",fontSize:13,fontWeight:a ? 700 : 500,cursor:"pointer",textAlign:"left",marginBottom:3,transition:"all 0.2s ease",borderLeft:"3px solid "+(a ? C.green1 : "transparent")}}>
                <Icon name={pg.i} size={18} color={a ? "#fff" : sev ? "#fca5a5" : "rgba(255,255,255,0.65)"}/>
                <span style={{flex:1}}>{pg.l}</span>
                {a && <div style={{width:6,height:6,borderRadius:"50%",background:"#fff"}}/>}
              </button>
            );
          })}
        </nav>
        <div style={{padding:"12px 18px",borderTop:"1px solid rgba(255,255,255,0.06)"}}>
          <button onClick={function(){setUser(null);}} style={{display:"flex",alignItems:"center",gap:7,background:"none",border:"none",color:"rgba(255,255,255,0.45)",cursor:"pointer",fontSize:12,fontWeight:600,padding:0}}><Icon name="logout" size={15} color="rgba(255,255,255,0.45)"/>Cikis Yap</button>
        </div>
      </aside>

      <main style={{flex:1,minWidth:0,display:"flex",flexDirection:"column"}}>
        <header style={{background:C.card,borderBottom:"1px solid "+C.borderLight,padding:"14px 20px",display:"flex",alignItems:"center",gap:12,position:"sticky",top:0,zIndex:30,backdropFilter:"blur(10px)",boxShadow:C.shadow}}>
          {mob && <button onClick={function(){setSbOpen(true);}} style={{background:"none",border:"none",cursor:"pointer",padding:6,display:"flex",alignItems:"center",justifyContent:"center",borderRadius:8,transition:"all 0.2s"}}><Icon name="menu" size={20}/></button>}
          <h1 style={{margin:0,fontSize:18,fontWeight:800,color:C.greenDark,letterSpacing:"-0.5px"}}>{titles[page]}</h1>
          
          {havaDurumu && <div style={{position:"relative"}}>
            <button onClick={function(){setHavaAcik(!havaAcik);}} style={{display:"flex",alignItems:"center",gap:6,padding:"6px 12px",background:C.green5,borderRadius:8,border:"1px solid "+C.green4,cursor:"pointer",background:"linear-gradient(135deg, "+C.green5+", "+C.green4+")"}}>
              <div style={{fontSize:16}}>🌤️</div>
              <div style={{fontSize:12,fontWeight:600,color:C.greenDark}}>{havaDurumu.temp}°</div>
              <div style={{fontSize:16}}>💧</div>
              <div style={{fontSize:12,fontWeight:600,color:C.greenDark}}>{havaDurumu.humidity}%</div>
              <div style={{fontSize:14}}>▼</div>
            </button>
            
            {havaAcik && <div style={{position:"absolute",top:"100%",left:0,marginTop:8,background:C.card,borderRadius:12,border:"1px solid "+C.borderLight,boxShadow:C.shadowLg,padding:16,minWidth:500,zIndex:100}}>
              <div style={{display:"flex",justifyContent:"space-between",alignItems:"center",marginBottom:12}}>
                <div style={{fontSize:14,fontWeight:700,color:C.text}}>7 Günlük Tahmin - Ankara</div>
                <button onClick={function(){setHavaAcik(false);}} style={{background:"none",border:"none",fontSize:18,cursor:"pointer"}}>✕</button>
              </div>
              
              <div style={{display:"grid",gridTemplateColumns:"repeat(7, 1fr)",gap:8}}>
                {havaDurumu.gunler.map(function(gun, idx) {
                  var tarih = new Date(gun.tarih);
                  var gun_adi = ["Paz","Pzt","Sal","Çar","Per","Cum","Cmt"][tarih.getDay()];
                  return (
                    <div key={idx} style={{background:C.bgWarm,borderRadius:10,padding:10,border:"1px solid "+C.borderLight,textAlign:"center"}}>
                      <div style={{fontSize:11,fontWeight:700,color:C.textMuted,marginBottom:6}}>{gun_adi}</div>
                      <div style={{fontSize:10,color:C.textMuted,marginBottom:8}}>{gun.tarih.slice(5)}</div>
                      <div style={{display:"flex",alignItems:"center",justifyContent:"center",gap:4,marginBottom:8}}>
                        <div style={{fontSize:13,fontWeight:800,color:C.greenDark}}>{gun.maxTemp}°</div>
                        <div style={{fontSize:10,color:C.textSoft}}>{gun.minTemp}°</div>
                      </div>
                      <div style={{borderTop:"1px solid "+C.borderLight,paddingTop:6,fontSize:10}}>
                        <div style={{display:"flex",alignItems:"center",justifyContent:"center",gap:4,marginBottom:4}}>
                          <span>💧</span>
                          <span style={{fontWeight:600,color:C.text}}>{gun.nem}%</span>
                        </div>
                        <div style={{display:"flex",alignItems:"center",justifyContent:"center",gap:4}}>
                          <span>💨</span>
                          <span style={{fontWeight:600,color:C.text}}>{gun.ruzgar} km/h</span>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
              
              <div style={{marginTop:12,padding:10,background:C.green5,borderRadius:8,fontSize:11,color:C.greenDark,textAlign:"center",fontWeight:600}}>
                📍 Ankara • 39.93°N, 32.85°E
              </div>
            </div>}
          </div>}
          
          <div style={{fontSize:13,fontWeight:600,color:C.textSoft,display:"flex",alignItems:"center",gap:4}}>⏰ {saat.toLocaleTimeString("tr-TR").slice(0,5)}</div>
          <div style={{flex:1}}/>
          <div style={{display:"flex",alignItems:"center",gap:10}}>
            <div style={{position:"relative",width:38,height:38,borderRadius:10,background:C.green5,display:"flex",alignItems:"center",justifyContent:"center",cursor:"pointer",border:"1px solid "+C.green4,transition:"all 0.2s"}}>
              <Icon name="bell" size={18} color={C.greenDark}/>
              {events.filter(function(e){return e.bildirim;}).length > 0 && <div style={{position:"absolute",top:-4,right:-4,width:20,height:20,borderRadius:"50%",background:C.coral,color:"#fff",fontSize:10,fontWeight:800,display:"flex",alignItems:"center",justifyContent:"center",border:"2px solid "+C.card}}>{events.filter(function(e){return e.bildirim;}).length}</div>}
            </div>
            <div style={{width:38,height:38,borderRadius:10,background:"linear-gradient(135deg,"+rC+","+C.greenDark+")",display:"flex",alignItems:"center",justifyContent:"center",color:"#fff",fontSize:12,fontWeight:800,boxShadow:C.shadow}}>{rL[0]}</div>
          </div>
        </header>
        <div style={{padding:20,maxWidth:1280,flex:1,width:"100%"}}>
          {page !== "sevme" && page !== "bildirimler" && (user === "yonetici" || user === "personel") && <BostanSel sel={bostan} onSel={setBostan}/>}
          {renderPage()}
        </div>
      </main>

      {toast && (
        <div style={{position:"fixed",bottom:20,right:20,background:C.greenDark,color:"#fff",padding:"12px 22px",borderRadius:12,fontSize:13,fontWeight:600,boxShadow:"0 8px 30px rgba(0,0,0,0.15)",zIndex:100,display:"flex",alignItems:"center",gap:8,animation:"fadeUp .3s ease"}}>
          <Icon name="check" size={16} color="#fff"/>{toast}
        </div>
      )}
    </div>
  );
}
