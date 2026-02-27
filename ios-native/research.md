# OpenPulse Stimulation Modes — Research Summary

## BLE Protocol Reality

Reverse engineering ([PulseLibre](https://github.com/jooray/PulseLibre), [hydrasparx](https://github.com/hydrasparx/pulsetto), [parallaxintelligencepartnership](https://github.com/parallaxintelligencepartnership/pulse-libre)) confirms that the Pulsetto device receives **no mode-specific parameters** over BLE. The official app's "modes" (Stress, Anxiety, Sleep, Burnout, Pain) are purely app-side presentation — the device itself only accepts:

| Command | Purpose |
|---------|---------|
| `D\n` | Start both channels |
| `A\n` | Start left channel only |
| `C\n` | Start right channel only |
| `0\n` | Stop |
| `1-9\n` | Set intensity level |
| `Q\n` | Query battery |
| `u\n` | Query charging |
| `i\n` | Query device ID |
| `v\n` | Query firmware version |

Pulsetto claims different carrier frequencies per mode (4,500–5,200 Hz), but these are either fixed in firmware or marketing claims — the app sends no frequency parameters.

**Our levers:** channel selection (A/C/D), intensity modulation (1-9), and duty cycling (start/stop commands) — all orchestrated from the app in real time.

---

## Mode Designs

### 1. Stress Relief — 6 min

| Parameter | Value | Evidence |
|-----------|-------|----------|
| Channel | Bilateral (`D`) | Bilateral safe ([Kim 2022](https://www.nature.com/articles/s41598-022-25864-1)), theoretically stronger NTS afferent input ([Yap 2020](https://pmc.ncbi.nlm.nih.gov/articles/PMC7199464/)) |
| Intensity | Constant at user-set level | All clinical studies use constant intensity |
| Duty cycle | Continuous (no off periods) | Continuous produced significant effects while intermittent 30s/30s did not ([Horinouchi 2024](https://pmc.ncbi.nlm.nih.gov/articles/PMC11099104/)); note: stimulation durations were not equivalent across conditions |
| Pattern | Flat — no modulation | Maximizes stimulation in limited time window |

**Evidence notes:**
- Acute HR effects during 60s stimulation trains ([Badran 2019](https://pmc.ncbi.nlm.nih.gov/articles/PMC6536129/): -2.4 BPM with 10 Hz/500 us)
- Meaningful HRV shifts at ~10 min ([Forte 2022](https://peerj.com/articles/14447/): RMSSD, SDNN, HF-HRV increases)
- taVNS blunts stress-induced cortisol rise (49.5% vs 106% from baseline during stress; [Cuberos Paredes 2025](https://pmc.ncbi.nlm.nih.gov/articles/PMC11815478/))
- 6 min is the minimum reasonable duration for effects beyond real-time HR
- No evidence supports intensity ramp-down; habituation data suggests the opposite
- Bilateral vs unilateral: no direct comparison for stress exists, but bilateral is safe ([Kim 2022](https://www.nature.com/articles/s41598-022-25864-1))

**Evidence grade: Strong**

---

### 2. Sleep — 10 min

| Parameter | Value | Evidence |
|-----------|-------|----------|
| Channel | Bilateral (`D`), slow rotation: D→A→D→C→D | Experimental — no published evidence for or against rotation |
| Intensity | Moderate (recommend 3-4), gentle fade last 2 min | Bottari 2024 found increased N3 sleep with taVNS in PTSD veterans ([J Sleep Research](https://onlinelibrary.wiley.com/doi/10.1111/jsr.13891)); fade-out is untested |
| Duty cycle | Continuous | [Bottari 2024](https://onlinelibrary.wiley.com/doi/10.1111/jsr.13891) used continuous stimulation |
| Rotation pace | ~2 min per channel position | Slow, non-alerting rhythm |

**Evidence notes:**
- Clinical insomnia studies use 20-30 min ([Zhang 2024](https://jamanetwork.com/journals/jamanetworkopen/fullarticle/2828072): 30 min 2x/day; [Wu 2022](https://pmc.ncbi.nlm.nih.gov/articles/PMC9599790/): 20 min 2x/day)
- Acute HRV effects do occur at 10 min ([Forte 2022](https://peerj.com/articles/14447/))
- **Critical:** Stimulation during the 2nd half of the night reduces deep sleep by ~5.5% ([Bottari/Williamson 2025](https://academic.oup.com/sleep/article/48/Supplement_1/A181/8135826), conference abstract) — never stimulate during sleep
- Use within 30 min of intended sleep onset
- Intensity fade-out is untested but physiologically aligned with wake→sleep autonomic transition
- Channel rotation is experimental — no published evidence for or against

**Evidence grade: Moderate** (channel rotation experimental; duration below clinical evidence base)

---

### 3. Focus — 6 min

| Parameter | Value | Evidence |
|-----------|-------|----------|
| Channel | Left only (`A`) | Most cognitive tVNS studies use left ear ([Thompson 2021](https://www.frontiersin.org/journals/neuroscience/articles/10.3389/fnins.2021.709436/full)) |
| Intensity | Moderate (4-5) | Inverted-U dose-response well-established ([Morrison 2018](https://pmc.ncbi.nlm.nih.gov/articles/PMC6347516/)) |
| Duty cycle | 30s on / 30s off | Standard in cognitive tVNS research; 30s epochs significantly increase salivary alpha-amylase while 3.4s epochs do not ([Bommer 2024](https://pmc.ncbi.nlm.nih.gov/articles/PMC11430400/)) |
| Use as | Pre-task primer (stimulate before work) | Offline > online for spatial working memory ([Sun 2021](https://www.frontiersin.org/journals/neuroscience/articles/10.3389/fnins.2021.790793/full)) |

**Evidence notes:**
- Inverted-U dose-response: moderate VNS intensity (0.8 mA) enhanced motor cortex plasticity; both lower (0.4 mA) and higher (1.6 mA) failed ([Morrison 2018](https://pmc.ncbi.nlm.nih.gov/articles/PMC6347516/))
- LC-NE activation occurs within seconds: pupil dilation peaks at 4.25s post-onset, alpha attenuation within 0-4s ([Sharon 2021](https://pmc.ncbi.nlm.nih.gov/articles/PMC7810665/))
- 30s on/30s off: standard duty cycle in cognitive research; each epoch demonstrably activates LC-NE system
- Offline (pre-task) stimulation significantly increased spatial 3-back hits; online stimulation showed no effect ([Sun 2021](https://www.frontiersin.org/journals/neuroscience/articles/10.3389/fnins.2021.790793/full))
- taVNS facilitates cortical arousal and alertness ([Chen 2023](https://pmc.ncbi.nlm.nih.gov/articles/PMC9859411/))
- Left ear not proven *superior* but is the most researched
- No evidence for alternating L/R for cognition — completely untested

**Evidence grade: Moderate-Strong**

---

### 4. Pain Relief — 8 min

| Parameter | Value | Evidence |
|-----------|-------|----------|
| Channel | Bilateral (`D`) | Max afferent coverage |
| Intensity | High-comfortable (user-set +1, capped at 9), slow oscillation ±1 on 30s wave | Adjusted amplitude TENS produced greater hypoalgesia ([Pantaleao 2011](https://pubmed.ncbi.nlm.nih.gov/21277840/)) |
| Duty cycle | Continuous | Short session — every off-second is wasted |
| Default | Higher than other modes (suggest 6-7) | TENS: higher comfortable intensity = better hypoalgesia |

**Evidence notes:**
- **Major caveat:** No published evidence that 5-10 min of auricular tVNS produces acute pain relief
- Closest precedent: gammaCore cervical VNS for migraine (two 120s doses; [Barbanti 2015](https://pmc.ncbi.nlm.nih.gov/articles/PMC4485661/)) — but targets different anatomical site (cervical vs auricular)
- Auricular pain studies use 30-60+ min: [Busch 2013](https://pubmed.ncbi.nlm.nih.gov/22621941/) (1 hr), [Straube 2015](https://pubmed.ncbi.nlm.nih.gov/26156114/) (4 hrs/day), CPM study found effects significant at 30 min ([Zhang 2024](https://pmc.ncbi.nlm.nih.gov/articles/PMC11543976/))
- Straube 2015: 1 Hz was significantly better than 25 Hz for chronic migraine ([PubMed 26156114](https://pubmed.ncbi.nlm.nih.gov/26156114/)) — we cannot control device frequency
- Intensity oscillation: [Pantaleao 2011](https://pubmed.ncbi.nlm.nih.gov/21277840/) found adjusted amplitude TENS produced greater hypoalgesia
- TENS literature is consistent: "strong but comfortable" > threshold or sub-threshold intensity

**Evidence grade: Weak** (short duration is the fundamental problem)

---

### 5. Calm / Breathe — 5 min

| Parameter | Value | Evidence |
|-----------|-------|----------|
| Channel | Bilateral (`D`) | Continuous, non-distracting |
| Breathing pace | 6 breaths/min (10s cycle: 4s inhale, 6s exhale) | Resonance frequency breathing — very robust standalone evidence for HRV |
| Stimulation gating | Exhale-gated: off during inhale, on during exhale | **RAVANS protocol (Napadow lab, Harvard/MGH)** |
| Intensity during exhale | Constant at user-set level (binary on/off) | RAVANS validates binary gating, not ramped |
| UI | Breathing animation: expand on inhale (stim off), contract on exhale (stim on) | Device as breathing pacer ([Szulczewski 2022](https://pubmed.ncbi.nlm.nih.gov/35396070/)) |

**Evidence notes:**
- **Exhalation-gated stimulation is established science:**
  - 7T fMRI: eRAVANS evoked significantly greater brainstem response than iRAVANS across NTS, dorsal raphe, median raphe, locus coeruleus ([Sclocco 2017](https://pmc.ncbi.nlm.nih.gov/articles/PMC6592731/))
  - Depression: eRAVANS produced 2.3x greater BDI-II reduction than iRAVANS (BDI -8.21 vs -3.58; [Garcia 2021](https://pmc.ncbi.nlm.nih.gov/articles/PMC8429271/))
  - HR: expiratory-gated reduced HR by -1.30% vs +0.11% for inspiratory-gated ([Paleczny 2019](https://pmc.ncbi.nlm.nih.gov/articles/PMC8041682/))
  - RAVANS in migraine: eRAVANS activated NTS-consistent pontomedullary region ([Garcia 2017](https://pmc.ncbi.nlm.nih.gov/articles/PMC5517046/))
- **Combined tVNS + slow breathing — mixed evidence:**
  - Positive: insomnia pilot — combined taVNS + 0.1 Hz breathing enhanced insomnia treatment efficacy ([Tian 2024](https://pubmed.ncbi.nlm.nih.gov/38042286/))
  - Negative: expiratory-gated taVNS did NOT augment HRV beyond slow breathing alone at 0.1 Hz, possible ceiling effect ([Szulczewski 2023](https://link.springer.com/article/10.1007/s10484-023-09584-4))
- The breathing guidance itself is the primary active ingredient
- Position as "guided resonance breathing with vagal stimulation" not "proven synergy"
- RAVANS uses binary on/off (1s bursts during exhale), not gradual ramp — staying with validated protocol

**Evidence grade: Strong** (exhalation gating is proven; combination synergy is mixed but clinically positive)

---

### 6. Atrial Fibrillation (AF) — 60 min

**NOTE: This mode requires a different device.** The Pulsetto stimulates the cervical vagus via the neck. All AF evidence is for **auricular (ear) stimulation at the tragus**. This section documents the protocol for use with a programmable TENS + tragus ear clip electrode, with OpenPulse serving as a session timer and adherence tracker.

| Parameter | Value | Evidence |
|-----------|-------|----------|
| Site | Tragus of ear (auricular branch of vagus nerve) | [TREAT AF](https://pmc.ncbi.nlm.nih.gov/articles/PMC7100921/), [Yu 2015](https://www.jacc.org/doi/abs/10.1016/j.jacc.2014.12.026), [Stavrakis 2021](https://www.ahajournals.org/doi/10.1161/JAHA.120.020865) — all used tragus |
| Frequency | 20 Hz | TREAT AF protocol; 20 vs 25 Hz never directly compared, likely equivalent |
| Pulse width | 200 us | TREAT AF protocol; 200-500 us all produce effects ([crossover trial 2025](https://pmc.ncbi.nlm.nih.gov/articles/PMC11940630/)) |
| Amplitude | Individually titrated: increase until discomfort, then reduce by 1 mA (~4-29 mA range, mean ~17 mA) | TREAT AF: "1 mA below discomfort threshold" |
| Waveform | Biphasic, constant current | Standard across all tVNS research |
| Duration | 60 min daily | TREAT AF: 1 hr/day for 6 months |
| Duty cycle | Continuous | TREAT AF used continuous stimulation |

**What "AF burden" means:**

AF burden = percentage of time the heart is in atrial fibrillation, measured continuously via implanted cardiac monitor (e.g., Medtronic LINQ). In TREAT AF, this was measured over 6 months.

**Key clinical results** ([Stavrakis 2020](https://pmc.ncbi.nlm.nih.gov/articles/PMC7100921/)):

| Outcome | Active (tragus) | Sham (earlobe) | Effect | p-value |
|---------|----------------|-----------------|--------|---------|
| AF burden at 6 months | ~0.5% (~7 min/day in AF) | ~3.0% (~43 min/day in AF) | **85% lower** (ratio 0.15) | 0.011 |
| Total AF duration | — | — | **83% lower** | 0.032 |
| Responders (>75% reduction) | 47% | 5% | — | 0.003 |
| TNF-alpha (inflammation) | — | — | **23% decrease** | 0.009 |
| Other cytokines (IL-6, IL-1b, IL-10, IL-17) | — | — | No significant difference | NS |

**What parameters matter most (evidence-ranked):**

1. **Stimulation site** (most critical) — Tragus/ear vs neck/earlobe is the difference between active treatment and sham. Cymba conchae may be even better (exclusively vagal innervation, stronger brainstem activation on fMRI; [Peuker 2002](https://pmc.ncbi.nlm.nih.gov/articles/PMC6607436/)) but tragus is what was validated in AF trials.
2. **Amplitude titration method** — "1 mA below discomfort" is the validated approach. Actual mA varies enormously across individuals (4-29 mA in TREAT AF). Fine mA control enables proper titration; Pulsetto's blind 1-9 levels cannot do this.
3. **Session duration** — 60 min/day is the only validated duration for AF. Shorter sessions have not been tested.
4. **Adherence** — TREAT AF active arm had 75% adherence. The app's primary role is tracking and encouraging adherence.
5. **Frequency** (marginal) — 20 Hz used in all AF trials. [Crossover trial (2025)](https://pmc.ncbi.nlm.nih.gov/articles/PMC11940630/) found non-linear inverted-U relationship between frequency and HRV; 10 Hz and 25 Hz both produced significant effects. 20 vs 25 Hz difference is likely negligible.
6. **Pulse width** (marginal) — 200 us in TREAT AF. 500 us is considered "most biologically active" but requires lower current. 200-500 us range all produce effects. No head-to-head comparison in AF patients.

**Why the Pulsetto cannot be used for AF:**

The Pulsetto stimulates the cervical vagus nerve through the neck. All AF evidence targets the auricular branch of the vagus nerve at the tragus of the ear. These are anatomically distinct pathways with different cardiac effects. No app modification can change the stimulation site — this is a hardware constraint.

**MVP hardware for AF protocol:**

| Component | Example | Approx cost |
|-----------|---------|-------------|
| Programmable TENS (20 Hz, 200 us) + ear clip | TragusClip Kit 1 (EV806P TENS + ear clip) | ~$165 |
| OpenPulse app | Session timer + adherence tracker | $0 |

**Advanced hardware (full BLE control):**

| Component | Example | Approx cost |
|-----------|---------|-------------|
| Open-source constant-current stimulator | NeuroStimDuino v3.0 (3-100 Hz, 0-2000 us, 0-22 mA) | $260 |
| BLE bridge | ESP32-S3 dev board | ~$10 |
| Tragus ear clip electrode | TENSPros or medical-grade silver clip | ~$15 |
| Batteries | 2x 18650 Li-ion | ~$15 |
| **Total** | | **~$310** |

**Upcoming trial to watch:**

VAST-AF (120 patients, persistent AF post-cardioversion, 1 hr/day for 3 months) — first RCT for persistent (not just paroxysmal) AF. ([Stavrakis 2023](https://www.sciencedirect.com/science/article/abs/pii/S0002870323003253))

**Evidence grade: Strong** (for paroxysmal AF with proper hardware; N/A for Pulsetto neck stimulation)

---

### 7. Custom — 4-10 min

Full manual control: user sets timer, intensity, no programmatic pattern. Current freeform behavior.

---

## Evidence Grading Summary

| Mode | Channel | Intensity | Duty Cycle | Overall |
|------|---------|-----------|------------|---------|
| Stress Relief | Evidence-informed | Evidence-based | Evidence-based | **Strong** |
| Sleep | Experimental (rotation) | Plausible (fade) | Evidence-based | **Moderate** |
| Focus | Convention-based (left) | Evidence-informed (inverted-U) | Evidence-based (30s/30s) | **Moderate-Strong** |
| Pain Relief | Reasonable | Experimental (oscillation) | Evidence-based | **Weak** |
| Calm/Breathe | Standard | **Evidence-based (RAVANS)** | **Evidence-based (respiratory gating)** | **Strong** |
| Custom | User choice | User choice | User choice | N/A |

---

## Key Research Sources

### Stress / Anxiety
- Horinouchi et al. (2024) — Continuous vs intermittent taVNS, short-latency afferent inhibition: [PMC11099104](https://pmc.ncbi.nlm.nih.gov/articles/PMC11099104/)
- Badran et al. (2019) — Short trains of taVNS and heart rate (-2.4 BPM, 10 Hz/500 us): [PMC6536129](https://pmc.ncbi.nlm.nih.gov/articles/PMC6536129/)
- Cuberos Paredes et al. (2025) — taVNS blunts stress-induced cortisol rise: [PMC11815478](https://pmc.ncbi.nlm.nih.gov/articles/PMC11815478/)
- Forte et al. (2022) — taVNS HRV effects (RMSSD, SDNN, HF-HRV): [PeerJ](https://peerj.com/articles/14447/)
- Kim et al. (2022) — Safety systematic review and meta-analysis of taVNS: [Nature Scientific Reports](https://www.nature.com/articles/s41598-022-25864-1)
- Yap et al. (2020) — Critical review of tVNS, bilateral afferent input: [PMC7199464](https://pmc.ncbi.nlm.nih.gov/articles/PMC7199464/)

### Sleep
- Zhang et al. (2024) — JAMA Network Open RCT, chronic insomnia, 30 min 2x/day: [JAMA](https://jamanetwork.com/journals/jamanetworkopen/fullarticle/2828072)
- Bottari et al. (2024) — tVNS increases N3 sleep in PTSD veterans (preliminary): [J Sleep Research](https://onlinelibrary.wiley.com/doi/10.1111/jsr.13891)
- Bottari/Williamson et al. (2025) — tVNS during 2nd half of night reduces N3 by ~5.5% (conference abstract): [SLEEP](https://academic.oup.com/sleep/article/48/Supplement_1/A181/8135826)
- Wu et al. (2022) — tVNS for primary insomnia, 20 min 2x/day: [PMC9599790](https://pmc.ncbi.nlm.nih.gov/articles/PMC9599790/)

### Focus / Cognition
- Sun et al. (2021) — taVNS spatial working memory, offline > online: [Frontiers in Neuroscience](https://www.frontiersin.org/journals/neuroscience/articles/10.3389/fnins.2021.790793/full)
- Morrison et al. (2018) — VNS intensity inverted-U curve (0.4/0.8/1.6 mA), motor cortex plasticity: [PMC6347516](https://pmc.ncbi.nlm.nih.gov/articles/PMC6347516/)
- Sharon et al. (2021) — tVNS pupil dilation (peak 4.25s) and alpha attenuation: [PMC7810665](https://pmc.ncbi.nlm.nih.gov/articles/PMC7810665/)
- Chen et al. (2023) — taVNS facilitates cortical arousal and alertness: [PMC9859411](https://pmc.ncbi.nlm.nih.gov/articles/PMC9859411/)
- Bommer et al. (2024) — 30s epochs increase salivary alpha-amylase, 3.4s do not: [PMC11430400](https://pmc.ncbi.nlm.nih.gov/articles/PMC11430400/)

### Pain
- Busch et al. (2013) — tVNS increases pain thresholds, 1 hr session: [PubMed 22621941](https://pubmed.ncbi.nlm.nih.gov/22621941/)
- Straube et al. (2015) — 1 Hz significantly better than 25 Hz for chronic migraine, 4 hrs/day: [PubMed 26156114](https://pubmed.ncbi.nlm.nih.gov/26156114/)
- Cao et al. (2021) — 1 Hz vs 20 Hz taVNS fMRI, vlPAG connectivity in migraine: [PMC8371886](https://pmc.ncbi.nlm.nih.gov/articles/PMC8371886/)
- Pantaleao et al. (2011) — Adjusted amplitude TENS produces greater hypoalgesia: [PubMed 21277840](https://pubmed.ncbi.nlm.nih.gov/21277840/)
- Zhang et al. (2024) — taVNS CPM enhancement in trigeminal neuralgia, effects at 30 min: [PMC11543976](https://pmc.ncbi.nlm.nih.gov/articles/PMC11543976/)
- Barbanti et al. (2015) — gammaCore cervical VNS for migraine (open-label): [PMC4485661](https://pmc.ncbi.nlm.nih.gov/articles/PMC4485661/)

### Calm / Breathe (RAVANS)
- Sclocco et al. (2017) — 7T fMRI, eRAVANS vs iRAVANS brainstem activation: [PMC6592731](https://pmc.ncbi.nlm.nih.gov/articles/PMC6592731/)
- Garcia et al. (2021) — RAVANS in major depression, eRAVANS 2.3x greater BDI-II reduction: [PMC8429271](https://pmc.ncbi.nlm.nih.gov/articles/PMC8429271/)
- Garcia et al. (2017) — RAVANS in migraine, NTS activation: [PMC5517046](https://pmc.ncbi.nlm.nih.gov/articles/PMC5517046/)
- Paleczny et al. (2019) — Expiratory vs inspiratory gated HR effects: [PMC8041682](https://pmc.ncbi.nlm.nih.gov/articles/PMC8041682/)
- Szulczewski (2022) — taVNS + slow breathing theoretical framework: [PubMed 35396070](https://pubmed.ncbi.nlm.nih.gov/35396070/)
- Szulczewski (2023) — Expiratory-gated taVNS does not augment HRV during slow breathing at 0.1 Hz: [Springer](https://link.springer.com/article/10.1007/s10484-023-09584-4)
- Tian et al. (2024) — Combined taVNS + 0.1 Hz breathing enhances insomnia treatment: [PubMed 38042286](https://pubmed.ncbi.nlm.nih.gov/38042286/)

### Atrial Fibrillation
- **Stavrakis et al. (2020) — TREAT AF RCT** (the key paper): [PMC7100921](https://pmc.ncbi.nlm.nih.gov/articles/PMC7100921/)
- Yu et al. (2015) — First human proof-of-concept, AF suppression during ablation: [JACC](https://www.jacc.org/doi/abs/10.1016/j.jacc.2014.12.026)
- Stavrakis et al. (2021) — Tragus stimulation modulates atrial alternans and AF burden: [JAHA](https://www.ahajournals.org/doi/10.1161/JAHA.120.020865)
- Low-level aVNS lowers BP/HR in paroxysmal AF (2025): [Frontiers in Neuroscience](https://www.frontiersin.org/journals/neuroscience/articles/10.3389/fnins.2025.1525027/full)
- Frequency/pulse width crossover trial, HRV in healthy adults (2025): [PMC11940630](https://pmc.ncbi.nlm.nih.gov/articles/PMC11940630/)
- VNS and AF paradox review: [Neuromodulation](https://www.neuromodulationjournal.org/article/S1094-7159(22)00029-0/fulltext)
- Stavrakis et al. (2023) — VAST-AF trial design (persistent AF, 120 patients): [ScienceDirect](https://www.sciencedirect.com/science/article/abs/pii/S0002870323003253)
- Cymba conchae vs tragus anatomy: [PMC6607436](https://pmc.ncbi.nlm.nih.gov/articles/PMC6607436/)

### General tVNS Parameters
- Thompson et al. (2021) — Parameter settings review, invasive and non-invasive VNS: [Frontiers in Neuroscience](https://www.frontiersin.org/journals/neuroscience/articles/10.3389/fnins.2021.709436/full)
- Yap et al. (2020) — Critical review of tVNS challenges: [PMC7199464](https://pmc.ncbi.nlm.nih.gov/articles/PMC7199464/)
- Farmer et al. (2021) — Minimum reporting standards consensus (Version 2020): [Frontiers in Human Neuroscience](https://www.frontiersin.org/journals/human-neuroscience/articles/10.3389/fnhum.2020.568051/full)

### BLE Protocol
- [jooray/PulseLibre](https://github.com/jooray/PulseLibre) — React Native mobile app
- [jooray/pulse-libre-desktop](https://github.com/jooray/pulse-libre-desktop) — Python desktop app
- [hydrasparx/pulsetto](https://github.com/hydrasparx/pulsetto) — Web Bluetooth (discovered A/C/D channel commands)
- [parallaxintelligencepartnership/pulse-libre](https://github.com/parallaxintelligencepartnership/pulse-libre) — Flutter app
- [FCC Filing 2A5T3-BXN-PU-22V001](https://fcc.report/FCC-ID/2A5T3-BXN-PU-22V001)
